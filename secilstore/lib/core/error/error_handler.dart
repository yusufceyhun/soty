import 'package:dio/dio.dart';

import 'app_exception.dart';

AppException mapDioError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return const TimeoutException();
    case DioExceptionType.connectionError:
      return const NetworkException();
    case DioExceptionType.badResponse:
      final statusCode = e.response?.statusCode;
      if (statusCode == 401) {
        return const UnauthorizedException();
      }
      if (statusCode != null && statusCode >= 500) {
        return const ServerException();
      }
      final message = _extractMessage(e.response?.data);
      if (message != null) {
        return ValidationException(message);
      }
      return const ServerException();
    case DioExceptionType.cancel:
      return const UnknownException('İstek iptal edildi.');
    case DioExceptionType.badCertificate:
      return const NetworkException('Güvenli bağlantı kurulamadı.');
    case DioExceptionType.unknown:
      if (e.error.toString().contains('SocketException')) {
        return const NetworkException();
      }
      return const UnknownException();
  }
}

String? _extractMessage(dynamic data) {
  if (data is Map<String, dynamic>) {
    final metaData = data['MetaData'] as Map<String, dynamic>?;
    if (metaData != null) {
      return metaData['Message'] as String?;
    }
    return data['message'] as String? ?? data['Message'] as String?;
  }
  return null;
}
