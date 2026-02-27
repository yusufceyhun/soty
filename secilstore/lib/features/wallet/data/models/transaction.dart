import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

@freezed
class WalletTransaction with _$WalletTransaction {
  const factory WalletTransaction({
    required String id,

    /// Direction: "Kazanç" (earning) or "Harcama" (spending)
    required String type,

    /// Sub-type: "Transfer", "Görev", "Alışveriş", "Kampanya", vb.
    String? transactionTypeName,
    required double amount,
    required double balance,
    required DateTime date,
    String? orderId,
    String? refundId,
    String? taskName,
    String? taskCategory,
    String? transferTo,
    String? brandName,
    String? campaignName,
    String? campaignRule,
  }) = _WalletTransaction;

  factory WalletTransaction.fromJson(Map<String, dynamic> json) =>
      _$WalletTransactionFromJson(json);
}
