// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SignInRequestImpl _$$SignInRequestImplFromJson(Map<String, dynamic> json) =>
    _$SignInRequestImpl(
      identifier: json['identifier'] as String,
      userName: json['userName'] as String?,
      verificationCode: json['verificationCode'] as String?,
    );

Map<String, dynamic> _$$SignInRequestImplToJson(_$SignInRequestImpl instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'userName': instance.userName,
      'verificationCode': instance.verificationCode,
    };
