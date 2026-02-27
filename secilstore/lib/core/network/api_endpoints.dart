class ApiEndpoints {
  ApiEndpoints._();

  static const String signIn = '/Mobile/v1/Auth/SignIn';
  static String walletSummary(String brandId) =>
      '/Mobile/v1/Wallet/Brands/$brandId/Summary';
  static String transactions(String brandId) =>
      '/Mobile/v1/Wallet/Brands/$brandId/Transactions';
  static const String pendingTransactions =
      '/Mobile/v1/Sotier/GetWaitingRewardCoin';
  static String activeCampaigns(String brandId) =>
      '/Mobile/v1/Campaign/GetActiveCampaign/$brandId';
  static const String generatePaymentCode =
      '/Mobile/v1/Campaign/GeneratePaymentQrCodeWithSotyCoinsAndCampaigns';
}
