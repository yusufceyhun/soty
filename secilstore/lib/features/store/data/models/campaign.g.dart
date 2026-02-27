// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CampaignImpl _$$CampaignImplFromJson(Map<String, dynamic> json) =>
    _$CampaignImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      isCombinable: json['isCombinable'] as bool,
      endDate: DateTime.parse(json['endDate'] as String),
      imageUrl: json['imageUrl'] as String?,
      brandLogoUrl: json['brandLogoUrl'] as String?,
      discountLabel: json['discountLabel'] as String?,
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$$CampaignImplToJson(_$CampaignImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'isCombinable': instance.isCombinable,
      'endDate': instance.endDate.toIso8601String(),
      'imageUrl': instance.imageUrl,
      'brandLogoUrl': instance.brandLogoUrl,
      'discountLabel': instance.discountLabel,
      'isActive': instance.isActive,
    };
