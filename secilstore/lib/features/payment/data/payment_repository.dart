import 'package:dio/dio.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/error/app_exception.dart';
import '../../../core/error/error_handler.dart';
import '../../../core/network/api_endpoints.dart';
import 'models/generate_code_request.dart';
import 'models/payment_code.dart';

class PaymentRepository {
  PaymentRepository(this._dio);

  final Dio _dio;

  Future<PaymentCode> generatePaymentCode({
    double? coinAmount,
    required List<String> campaignIds,
  }) async {
    try {
      final request = GenerateCodeRequest(
        brandId: AppConstants.brandId,
        campaignIds: campaignIds,
        coinAmount: coinAmount,
      );

      final response = await _dio.post(
        ApiEndpoints.generatePaymentCode,
        data: request.toJson(),
      );

      final data = response.data as Map<String, dynamic>?;
      if (data == null) throw const ServerException('QR kodu oluşturulamadı.');

      final responseData = data['responseData'] as Map<String, dynamic>?;
      final code = responseData?['paymentCode'] as String?;

      if (code == null || code.isEmpty) {
        throw const ServerException('QR kodu oluşturulamadı.');
      }

      return PaymentCode(
        code: code,
        generatedAt: DateTime.now(),
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
}
