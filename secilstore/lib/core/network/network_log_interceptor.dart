import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class NetworkLogInterceptor extends Interceptor {
  NetworkLogInterceptor({
    required this.verbose,
  });

  final bool verbose;
  final Map<RequestOptions, Stopwatch> _timers = <RequestOptions, Stopwatch>{};

  static const Set<String> _sensitiveHeaders = <String>{
    'authorization',
    'cookie',
    'set-cookie',
    'x-api-key',
  };

  static const Set<String> _sensitiveKeys = <String>{
    'identifier',
    'phonenumber',
    'phone',
    'verificationcode',
    'password',
    'token',
    'accesstoken',
    'refreshtoken',
  };

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final timer = Stopwatch()..start();
    _timers[options] = timer;

    if (verbose) {
      final sanitizedHeaders = Map<String, dynamic>.from(options.headers);
      for (final key in sanitizedHeaders.keys.toList()) {
        if (_sensitiveHeaders.contains(key.toLowerCase())) {
          sanitizedHeaders[key] = '***';
        }
      }

      final sanitizedBody = _sanitizeData(options.data);

      debugPrint(
        '--> ${options.method} ${options.uri}\n'
        'headers=${_safeEncode(sanitizedHeaders)}\n'
        'data=${_safeEncode(sanitizedBody)}',
      );
    } else {
      debugPrint('--> ${options.method} ${options.uri}');
    }

    handler.next(options);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    final timer = _timers.remove(response.requestOptions);
    final elapsedMs = timer?.elapsedMilliseconds ?? 0;
    debugPrint(
      '<-- ${response.statusCode} ${response.requestOptions.method} '
      '${response.requestOptions.uri} (${elapsedMs}ms)',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final timer = _timers.remove(err.requestOptions);
    final elapsedMs = timer?.elapsedMilliseconds ?? 0;
    debugPrint(
      '<-- ERROR ${err.response?.statusCode ?? '-'} '
      '${err.requestOptions.method} ${err.requestOptions.uri} '
      '(${elapsedMs}ms): ${err.message}',
    );
    handler.next(err);
  }

  dynamic _sanitizeData(dynamic value) {
    if (value is Map) {
      final result = <String, dynamic>{};
      for (final entry in value.entries) {
        final key = entry.key.toString();
        final normalized = key.replaceAll('_', '').toLowerCase();
        result[key] = _sensitiveKeys.contains(normalized)
            ? '***'
            : _sanitizeData(entry.value);
      }
      return result;
    }

    if (value is List) {
      return value.map(_sanitizeData).toList();
    }

    return value;
  }

  String _safeEncode(dynamic value) {
    try {
      return jsonEncode(value);
    } catch (_) {
      return value.toString();
    }
  }
}
