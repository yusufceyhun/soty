import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  SecureStorage() : _storage = const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  static const _accessTokenKey = '_access_token';
  static const _refreshTokenKey = '_refresh_token';
  static const _phoneKey = '_phone';

  Future<void> saveTokens({
    required String access,
    required String refresh,
  }) async {
    await Future.wait([
      _storage.write(key: _accessTokenKey, value: access),
      _storage.write(key: _refreshTokenKey, value: refresh),
    ]);
  }

  Future<String?> getAccessToken() async {
    return _storage.read(key: _accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    return _storage.read(key: _refreshTokenKey);
  }

  Future<void> savePhone(String phone) async {
    await _storage.write(key: _phoneKey, value: phone);
  }

  Future<String?> getPhone() async {
    return _storage.read(key: _phoneKey);
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
