class AppConstants {
  AppConstants._();

  static const String brandId = '550e8400-e29b-41d4-a716-446655440000';
  static const String baseUrl = 'https://stage-api.soty.io';
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const int otpLength = 6;
  static const int otpTimerSecs = 59;
  static const int qrRefreshSecs = 60;
  static const int pageSize = 20;
}
