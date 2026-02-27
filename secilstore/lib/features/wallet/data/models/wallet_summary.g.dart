// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WalletSummaryImpl _$$WalletSummaryImplFromJson(Map<String, dynamic> json) =>
    _$WalletSummaryImpl(
      totalBalance: (json['totalBalance'] as num).toDouble(),
      availableBalance: (json['availableBalance'] as num).toDouble(),
      tierName: json['tierName'] as String?,
      cardColor: json['cardColor'] as String?,
      brandName: json['brandName'] as String?,
      brandLogo: json['brandLogo'] as String?,
      walletLogo: json['walletLogo'] as String?,
      walletCover: json['walletCover'] as String?,
      onlineCampaignCount: (json['onlineCampaignCount'] as num?)?.toInt() ?? 0,
      storeCampaignCount: (json['storeCampaignCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$WalletSummaryImplToJson(_$WalletSummaryImpl instance) =>
    <String, dynamic>{
      'totalBalance': instance.totalBalance,
      'availableBalance': instance.availableBalance,
      'tierName': instance.tierName,
      'cardColor': instance.cardColor,
      'brandName': instance.brandName,
      'brandLogo': instance.brandLogo,
      'walletLogo': instance.walletLogo,
      'walletCover': instance.walletCover,
      'onlineCampaignCount': instance.onlineCampaignCount,
      'storeCampaignCount': instance.storeCampaignCount,
    };
