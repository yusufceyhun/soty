import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_code.freezed.dart';
part 'payment_code.g.dart';

@freezed
class PaymentCode with _$PaymentCode {
  const factory PaymentCode({
    required String code,
    required DateTime generatedAt,
    @Default(60) int expiresInSeconds,
  }) = _PaymentCode;

  factory PaymentCode.fromJson(Map<String, dynamic> json) =>
      _$PaymentCodeFromJson(json);
}
