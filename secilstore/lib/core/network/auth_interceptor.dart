import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/core_providers.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._ref);

  final Ref _ref;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final token = await _ref.read(secureStorageProvider).getAccessToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('AuthInterceptor: Failed to read token: $e');
      }
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        await _ref.read(secureStorageProvider).clearAll();
        _ref.read(authRedirectCallbackProvider)?.call();
      } catch (e) {
        if (kDebugMode) {
          debugPrint('AuthInterceptor: Failed to handle 401: $e');
        }
      }
    }
    handler.next(err);
  }
}
