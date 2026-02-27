import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/formatters.dart';
import '../data/models/pending_transaction.dart';
import '../providers/wallet_providers.dart';
import 'widgets/transaction_countdown_timer.dart';

class PendingTransactionDetailScreen extends ConsumerWidget {
  const PendingTransactionDetailScreen({
    required this.transaction,
    super.key,
  });

  final PendingTransaction transaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subItems = transaction.subItems ?? const <PendingSubItem>[];
    final title = subItems.isNotEmpty
        ? subItems.first.name
        : transaction.orderId != null && transaction.orderId!.isNotEmpty
            ? 'Sipariş #${transaction.orderId}'
            : 'Bekleyen İşlem';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Geri',
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left),
        ),
        title: Text(
          'Bekleyen İşlem Detayı',
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.cardBg,
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(color: AppColors.divider.withValues(alpha: 0.5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.titleLarge.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Toplam Bekleyen Coin',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    Formatters.formatCoinWithSign(transaction.amount),
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: AppColors.pending,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TransactionCountdownTimer(
                    estimatedDate: transaction.estimatedDate,
                    onExpire: () {
                      ref.invalidate(walletSummaryProvider);
                      ref.invalidate(pendingTransactionsDataProvider);
                      ref.invalidate(pendingTransactionsProvider);
                      ref.invalidate(transactionsProvider);
                    },
                  ),
                  if (transaction.orderId != null &&
                      transaction.orderId!.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Sipariş No',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      transaction.orderId!,
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (subItems.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Bekleyen Kalemler',
                style: AppTextStyles.titleLarge.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              ...subItems.map(
                (item) => Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.cardBg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.divider.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: AppTextStyles.titleMedium.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                            if (item.description != null &&
                                item.description!.isNotEmpty) ...[
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                item.description!,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Text(
                        Formatters.formatCoinWithSign(item.amount),
                        style: AppTextStyles.titleMedium.copyWith(
                          color: AppColors.pending,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
