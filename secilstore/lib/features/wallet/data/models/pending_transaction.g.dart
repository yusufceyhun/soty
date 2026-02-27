// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PendingTransactionImpl _$$PendingTransactionImplFromJson(
        Map<String, dynamic> json) =>
    _$PendingTransactionImpl(
      id: json['id'] as String,
      amount: (json['amount'] as num).toDouble(),
      estimatedDate: DateTime.parse(json['estimatedDate'] as String),
      orderId: json['orderId'] as String?,
      subItems: (json['subItems'] as List<dynamic>?)
          ?.map((e) => PendingSubItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PendingTransactionImplToJson(
        _$PendingTransactionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'estimatedDate': instance.estimatedDate.toIso8601String(),
      'orderId': instance.orderId,
      'subItems': instance.subItems,
    };

_$PendingSubItemImpl _$$PendingSubItemImplFromJson(Map<String, dynamic> json) =>
    _$PendingSubItemImpl(
      name: json['name'] as String,
      description: json['description'] as String?,
      amount: (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$$PendingSubItemImplToJson(
        _$PendingSubItemImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'amount': instance.amount,
    };
