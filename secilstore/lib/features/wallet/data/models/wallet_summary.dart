import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_summary.freezed.dart';
part 'wallet_summary.g.dart';

@freezed
class WalletSummary with _$WalletSummary {
  const factory WalletSummary({
    required double totalBalance,
    required double availableBalance,
    String? tierName,
    String? cardColor,
    String? brandName,

    /// Brand logo URL from API
    String? brandLogo,

    /// Wallet logo URL displayed on the card
    String? walletLogo,

    /// Card background image URL
    String? walletCover,
    @Default(0) int onlineCampaignCount,
    @Default(0) int storeCampaignCount,
  }) = _WalletSummary;

  factory WalletSummary.fromJson(Map<String, dynamic> json) =>
      _$WalletSummaryFromJson(json);
}
