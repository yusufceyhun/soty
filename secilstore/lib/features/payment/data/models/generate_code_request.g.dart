// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_code_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GenerateCodeRequestImpl _$$GenerateCodeRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$GenerateCodeRequestImpl(
      brandId: json['brandId'] as String,
      campaignIds: (json['campaignIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      coinAmount: (json['coinAmount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$GenerateCodeRequestImplToJson(
        _$GenerateCodeRequestImpl instance) =>
    <String, dynamic>{
      'brandId': instance.brandId,
      'campaignIds': instance.campaignIds,
      'coinAmount': instance.coinAmount,
    };
