import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/error/app_exception.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/coin_icon.dart';
import '../providers/payment_providers.dart';
import 'widgets/barcode_display_widget.dart';
import 'widgets/code_countdown_timer.dart';
import 'widgets/qr_code_widget.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  const PaymentScreen({
    required this.coinAmount,
    required this.campaignIds,
    required this.campaignNames,
    super.key,
  });

  final double? coinAmount;
  final List<String> campaignIds;
  final List<String> campaignNames;

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  final _timerKey = GlobalKey<CodeCountdownTimerState>();
  bool _showBarcode = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(paymentNotifierProvider.notifier).generateCode(
            coinAmount: widget.coinAmount,
            campaignIds: widget.campaignIds,
          );
    });
  }

  void _refresh() {
    ref.read(paymentNotifierProvider.notifier).manualRefresh(
          coinAmount: widget.coinAmount,
          campaignIds: widget.campaignIds,
        );
    _timerKey.currentState?.restart();
  }

  void _copyCode(String code) {
    Clipboard.setData(ClipboardData(text: code));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kod kopyalandı'),
          duration: Duration(seconds: 2),
          backgroundColor: AppColors.positive,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final codeState = ref.watch(paymentNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Geri',
          onPressed: () => context.pop(),
          icon: const Icon(
            Icons.chevron_left,
            color: AppColors.textPrimary,
            size: 28,
          ),
        ),
        title: Text(
          'Mağaza Alışverişi',
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // QR / Barcode toggle (always visible)
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.md,
              AppSpacing.md,
              0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: _TabButton(
                    label: 'QR Kod',
                    isActive: !_showBarcode,
                    onTap: () => setState(() => _showBarcode = false),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _TabButton(
                    label: 'Barkod',
                    isActive: _showBarcode,
                    onTap: () => setState(() => _showBarcode = true),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          // Main content — switches based on state
          Expanded(
            child: codeState.when(
              loading: () => const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
              error: (e, _) => _ErrorBody(
                message: e is AppException
                    ? e.userMessage
                    : 'Birleştirme için en az bir kampanya\nveya coin miktarı belirtilmelidir.',
                onRetry: _refresh,
              ),
              data: (paymentCode) {
                if (paymentCode == null) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  );
                }
                return _SuccessBody(
                  paymentCode: paymentCode.code,
                  showBarcode: _showBarcode,
                  timerKey: _timerKey,
                  coinAmount: widget.coinAmount,
                  campaignNames: widget.campaignNames,
                  onRefresh: _refresh,
                  onCopy: _copyCode,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Tab Button (QR Kod / Barkod) ──────────────────────────────────────────

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: isActive ? AppColors.primary : Colors.transparent,
          border: Border.all(
            color: isActive ? AppColors.primary : AppColors.inputBorder,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.labelLarge.copyWith(
            color: isActive ? Colors.white : AppColors.textSecondary,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

// ─── Error Body (matches Image 1 exactly) ──────────────────────────────────

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.xxl),
          // Error icon (pink circle with !)
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.1),
            ),
            child: const Icon(
              Icons.error_outline,
              size: 36,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            message,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          // "Tekrar Dene" outlined pill button
          OutlinedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh, size: 18, color: AppColors.primary),
            label: Text(
              'Tekrar Dene',
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.primary,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.sm,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Success Body (QR/Barcode + Timer + Refresh + Info) ────────────────────

class _SuccessBody extends StatelessWidget {
  const _SuccessBody({
    required this.paymentCode,
    required this.showBarcode,
    required this.timerKey,
    required this.coinAmount,
    required this.campaignNames,
    required this.onRefresh,
    required this.onCopy,
  });

  final String paymentCode;
  final bool showBarcode;
  final GlobalKey<CodeCountdownTimerState> timerKey;
  final double? coinAmount;
  final List<String> campaignNames;
  final VoidCallback onRefresh;
  final ValueChanged<String> onCopy;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        children: [
          // QR or Barcode
          showBarcode
              ? BarcodeDisplayWidget(data: paymentCode)
              : QrCodeWidget(data: paymentCode),
          const SizedBox(height: AppSpacing.md),
          // Code display + copy
          GestureDetector(
            onTap: () => onCopy(paymentCode),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.divider.withValues(alpha: 0.5),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    paymentCode,
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.textPrimary,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  const Icon(
                    Icons.copy,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          // Timer
          CodeCountdownTimer(
            key: timerKey,
            onExpired: onRefresh,
            onRefresh: onRefresh,
          ),
          const SizedBox(height: AppSpacing.md),
          // Refresh button
          AppButton(
            label: 'Kodu Yenile',
            onPressed: onRefresh,
          ),
          const SizedBox(height: AppSpacing.lg),
          // Coin summary
          if (coinAmount != null && coinAmount! > 0)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.cardBg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.divider.withValues(alpha: 0.5),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Kullanılacak Soty Coin',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CoinIcon(size: 24),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        Formatters.formatCoin(coinAmount!),
                        style: AppTextStyles.headlineLarge.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          // Campaigns section
          if (campaignNames.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.cardBg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.divider.withValues(alpha: 0.5),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kullanılan Kampanyalar',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  ...campaignNames.map((name) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.local_offer_outlined,
                              size: 16,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Text(
                                name,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          // Info text
          Text(
            'Bu kodu kasadaki personele gösteriniz.\nKod her 60 saniyede otomatik yenilenir.',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }
}
