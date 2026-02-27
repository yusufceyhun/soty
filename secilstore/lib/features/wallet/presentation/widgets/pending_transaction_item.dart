import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../data/models/pending_transaction.dart';
import '../../providers/wallet_providers.dart';
import 'transaction_countdown_timer.dart';

class PendingTransactionItem extends ConsumerStatefulWidget {
  const PendingTransactionItem({required this.transaction, super.key});

  final PendingTransaction transaction;

  @override
  ConsumerState<PendingTransactionItem> createState() =>
      _PendingTransactionItemState();
}

class _PendingTransactionItemState
    extends ConsumerState<PendingTransactionItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final tx = widget.transaction;
    final subItems = tx.subItems ?? const <PendingSubItem>[];

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  const Icon(
                    Icons.hourglass_bottom,
                    size: 28,
                    color: AppColors.pending,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bekleyen İşlem',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        TransactionCountdownTimer(
                          estimatedDate: tx.estimatedDate,
                          onExpire: () {
                            // Re-fetch both pending and ledger lists so expired items
                            // can move out of "Bekleyen" into earnings.
                            ref.invalidate(walletSummaryProvider);
                            ref.invalidate(pendingTransactionsDataProvider);
                            ref.invalidate(pendingTransactionsProvider);
                            ref.invalidate(transactionsProvider);
                          },
                        ),
                      ],
                    ),
                  ),
                  Text(
                    Formatters.formatCoinWithSign(tx.amount),
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.pending,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded && subItems.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                0,
                AppSpacing.md,
                AppSpacing.md,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(height: 1, color: AppColors.divider),
                  const SizedBox(height: AppSpacing.md),
                  if (tx.orderId != null) ...[
                    Text(
                      'Sipariş No: ${tx.orderId}',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                  ],
                  ...subItems.map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                item.name,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              Formatters.formatCoinWithSign(item.amount),
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.pending,
                                fontFeatures: const [
                                  FontFeature.tabularFigures(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
