sealed class AppException implements Exception {
  const AppException();

  String get userMessage;
}

class NetworkException extends AppException {
  const NetworkException([this._message]);

  final String? _message;

  @override
  String get userMessage => _message ?? 'İnternet bağlantınızı kontrol ediniz.';
}

class TimeoutException extends AppException {
  const TimeoutException([this._message]);

  final String? _message;

  @override
  String get userMessage => _message ?? 'İstek zaman aşımına uğradı.';
}

class UnauthorizedException extends AppException {
  const UnauthorizedException([this._message]);

  final String? _message;

  @override
  String get userMessage =>
      _message ?? 'Oturum süreniz dolmuştur. Lütfen tekrar giriş yapınız.';
}

class ServerException extends AppException {
  const ServerException([this._message]);

  final String? _message;

  @override
  String get userMessage =>
      _message ?? 'Bir hata oluştu. Lütfen daha sonra tekrar deneyiniz.';
}

class ValidationException extends AppException {
  const ValidationException(this._message);

  final String _message;

  @override
  String get userMessage => _message;
}

class UnknownException extends AppException {
  const UnknownException([this._message]);

  final String? _message;

  @override
  String get userMessage => _message ?? 'Beklenmeyen bir hata oluştu.';
}
