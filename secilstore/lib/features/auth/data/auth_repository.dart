import 'package:dio/dio.dart';

import '../../../core/error/app_exception.dart';
import '../../../core/error/error_handler.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/storage/secure_storage.dart';
import 'models/auth_response.dart';
import 'models/sign_in_request.dart';

class AuthRepository {
  AuthRepository(this._dio, this._storage);

  final Dio _dio;
  final SecureStorage _storage;

  Future<void> requestOtp(String phoneNumber) async {
    try {
      final request = SignInRequest(
        identifier: phoneNumber,
        userName: null,
        verificationCode: null,
      );

      final response = await _dio.post(
        ApiEndpoints.signIn,
        data: request.toJson(),
      );

      final statusCode = response.statusCode;
      final data = response.data as Map<String, dynamic>?;

      if (statusCode == 202 || statusCode == 200) {
        final metaData = data?['MetaData'] as Map<String, dynamic>?;
        final responseCode = metaData?['ResponseCode'] as int?;

        if (responseCode == 5211) {
          return;
        }

        final message = metaData?['Message'] as String?;
        throw ValidationException(
          message ?? 'Doğrulama kodu gönderilemedi.',
        );
      }

      throw const ServerException('Beklenmeyen bir yanıt alındı.');
    } on AppException {
      rethrow;
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (e) {
      if (e is AppException) rethrow;
      throw const UnknownException();
    }
  }

  Future<AuthResponse> verifyOtp(String phone, String otp) async {
    try {
      final request = SignInRequest(
        identifier: phone,
        userName: null,
        verificationCode: otp,
      );

      final response = await _dio.post(
        ApiEndpoints.signIn,
        data: request.toJson(),
      );

      final data = response.data as Map<String, dynamic>?;

      if (response.statusCode == 200 && data != null) {
        final responseData = data['responseData'] as Map<String, dynamic>?;

        if (responseData != null) {
          final authResponse = AuthResponse.fromJson(responseData);

          await _storage.saveTokens(
            access: authResponse.accessToken,
            refresh: authResponse.refreshToken,
          );
          await _storage.savePhone(phone);

          return authResponse;
        }
      }

      final metaData = data?['MetaData'] as Map<String, dynamic>?;
      final message = metaData?['Message'] as String?;

      throw ValidationException(
        message ?? 'Doğrulama kodu yanlış.',
      );
    } on AppException {
      rethrow;
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (e) {
      if (e is AppException) rethrow;
      throw const UnknownException();
    }
  }

  Future<void> logout() async {
    await _storage.clearAll();
  }
}
