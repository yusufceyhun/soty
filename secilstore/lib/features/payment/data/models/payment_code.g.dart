// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentCodeImpl _$$PaymentCodeImplFromJson(Map<String, dynamic> json) =>
    _$PaymentCodeImpl(
      code: json['code'] as String,
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      expiresInSeconds: (json['expiresInSeconds'] as num?)?.toInt() ?? 60,
    );

Map<String, dynamic> _$$PaymentCodeImplToJson(_$PaymentCodeImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'generatedAt': instance.generatedAt.toIso8601String(),
      'expiresInSeconds': instance.expiresInSeconds,
    };
