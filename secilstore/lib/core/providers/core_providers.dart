import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constants/app_constants.dart';
import '../network/auth_interceptor.dart';
import '../network/network_log_interceptor.dart';
import '../storage/secure_storage.dart';

part 'core_providers.g.dart';

@riverpod
SecureStorage secureStorage(Ref ref) {
  return SecureStorage();
}

@riverpod
Dio dioClient(Ref ref) {
  const enableNetworkLogs =
      bool.fromEnvironment('ENABLE_NETWORK_LOGS', defaultValue: false);
  const verboseNetworkLogs =
      bool.fromEnvironment('VERBOSE_NETWORK_LOGS', defaultValue: false);

  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: AppConstants.connectTimeout,
      receiveTimeout: AppConstants.receiveTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': '*/*',
      },
    ),
  );

  dio.interceptors.addAll([
    AuthInterceptor(ref),
    if (kDebugMode && enableNetworkLogs)
      NetworkLogInterceptor(
        verbose: verboseNetworkLogs,
      ),
  ]);

  return dio;
}

final authRedirectCallbackProvider =
    StateProvider<VoidCallback?>((ref) => null);
