import 'package:freezed_annotation/freezed_annotation.dart';

part 'pending_transaction.freezed.dart';
part 'pending_transaction.g.dart';

@freezed
class PendingTransaction with _$PendingTransaction {
  const factory PendingTransaction({
    required String id,
    required double amount,
    required DateTime estimatedDate,
    String? orderId,
    List<PendingSubItem>? subItems,
  }) = _PendingTransaction;

  factory PendingTransaction.fromJson(Map<String, dynamic> json) =>
      _$PendingTransactionFromJson(json);
}

@freezed
class PendingSubItem with _$PendingSubItem {
  const factory PendingSubItem({
    required String name,
    String? description,
    required double amount,
  }) = _PendingSubItem;

  factory PendingSubItem.fromJson(Map<String, dynamic> json) =>
      _$PendingSubItemFromJson(json);
}
