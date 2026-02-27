// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WalletTransactionImpl _$$WalletTransactionImplFromJson(
        Map<String, dynamic> json) =>
    _$WalletTransactionImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      transactionTypeName: json['transactionTypeName'] as String?,
      amount: (json['amount'] as num).toDouble(),
      balance: (json['balance'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      orderId: json['orderId'] as String?,
      refundId: json['refundId'] as String?,
      taskName: json['taskName'] as String?,
      taskCategory: json['taskCategory'] as String?,
      transferTo: json['transferTo'] as String?,
      brandName: json['brandName'] as String?,
      campaignName: json['campaignName'] as String?,
      campaignRule: json['campaignRule'] as String?,
    );

Map<String, dynamic> _$$WalletTransactionImplToJson(
        _$WalletTransactionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'transactionTypeName': instance.transactionTypeName,
      'amount': instance.amount,
      'balance': instance.balance,
      'date': instance.date.toIso8601String(),
      'orderId': instance.orderId,
      'refundId': instance.refundId,
      'taskName': instance.taskName,
      'taskCategory': instance.taskCategory,
      'transferTo': instance.transferTo,
      'brandName': instance.brandName,
      'campaignName': instance.campaignName,
      'campaignRule': instance.campaignRule,
    };
