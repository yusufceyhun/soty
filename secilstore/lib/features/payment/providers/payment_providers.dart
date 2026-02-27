import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/error/app_exception.dart';
import '../../../core/providers/core_providers.dart';
import '../data/models/payment_code.dart';
import '../data/payment_repository.dart';

part 'payment_providers.g.dart';

@riverpod
PaymentRepository paymentRepository(Ref ref) {
  return PaymentRepository(ref.watch(dioClientProvider));
}

@riverpod
class PaymentNotifier extends _$PaymentNotifier {
  @override
  AsyncValue<PaymentCode?> build() => const AsyncData(null);

  Future<void> generateCode({
    double? coinAmount,
    required List<String> campaignIds,
  }) async {
    state = const AsyncLoading();

    try {
      final code =
          await ref.read(paymentRepositoryProvider).generatePaymentCode(
                coinAmount: coinAmount,
                campaignIds: campaignIds,
              );
      state = AsyncData(code);
    } on AppException catch (e, st) {
      state = AsyncError(e, st);
    } catch (e, st) {
      state = AsyncError(const UnknownException(), st);
    }
  }

  void manualRefresh({
    double? coinAmount,
    required List<String> campaignIds,
  }) {
    generateCode(coinAmount: coinAmount, campaignIds: campaignIds);
  }
}
