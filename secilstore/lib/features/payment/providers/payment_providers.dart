import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/error/app_exception.dart';
import '../../../core/providers/core_providers.dart';
import '../../../core/services/analytics_service.dart';
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
    String trigger = 'initial',
  }) async {
    state = const AsyncLoading();

    try {
      final code =
          await ref.read(paymentRepositoryProvider).generatePaymentCode(
                coinAmount: coinAmount,
                campaignIds: campaignIds,
              );
      state = AsyncData(code);
      await AnalyticsService.logGenerateQr(
        campaignCount: campaignIds.length,
        coinAmount: coinAmount ?? 0,
      );
      if (trigger != 'initial') {
        await AnalyticsService.logQrRefresh(trigger: trigger);
      }
    } on AppException catch (e, st) {
      state = AsyncError(e, st);
    } catch (e, st) {
      state = AsyncError(const UnknownException(), st);
    }
  }

  void manualRefresh({
    double? coinAmount,
    required List<String> campaignIds,
    String trigger = 'manual',
  }) {
    generateCode(
      coinAmount: coinAmount,
      campaignIds: campaignIds,
      trigger: trigger,
    );
  }
}
