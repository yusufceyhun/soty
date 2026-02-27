import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../data/models/transaction.dart';
import 'transaction_detail_row.dart';

class TransactionListItem extends StatefulWidget {
  const TransactionListItem({required this.transaction, super.key});

  final WalletTransaction transaction;

  @override
  State<TransactionListItem> createState() => _TransactionListItemState();
}

class _TransactionListItemState extends State<TransactionListItem> {
  bool _isExpanded = false;

  IconData get _icon {
    // Use transactionTypeName (Transfer, Görev, Alışveriş…) for icon
    final subType = widget.transaction.transactionTypeName ?? '';
    return switch (subType) {
      'Transfer' => Icons.swap_horiz,
      'Görev' => Icons.checklist_outlined,
      'Alışveriş' => Icons.shopping_bag_outlined,
      'İade' => Icons.keyboard_return_outlined,
      'Kampanya' => Icons.local_offer_outlined,
      'Hediye' => Icons.card_giftcard_outlined,
      'Görev Silindi' => Icons.error_outline,
      _ => Icons.receipt_outlined,
    };
  }

  Color get _amountColor {
    // Use type direction: "Kazanç" = positive (green), "Harcama" = negative (red)
    final direction = widget.transaction.type;
    if (direction == 'Kazanç') return AppColors.positive;
    if (direction == 'Harcama') return AppColors.negative;
    // Fallback: use sign of amount
    if (widget.transaction.amount > 0) return AppColors.positive;
    if (widget.transaction.amount < 0) return AppColors.negative;
    return AppColors.textSecondary;
  }

  @override
  Widget build(BuildContext context) {
    final tx = widget.transaction;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.divider.withValues(alpha: 0.5),
        ),
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
                  // Leading icon
                  Icon(
                    _icon,
                    size: 28,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  // Title + date
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              tx.transactionTypeName ?? tx.type,
                              style: AppTextStyles.titleMedium.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Icon(
                              Icons.info_outline,
                              size: 14,
                              color: AppColors.textSecondary
                                  .withValues(alpha: 0.6),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          Formatters.formatDate(tx.date),
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Amount + balance
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        // API "coin" is always unsigned; derive sign from "type" direction
                        tx.type == 'Kazanç'
                            ? '+${Formatters.formatCoin(tx.amount)}'
                            : tx.type == 'Harcama'
                                ? '-${Formatters.formatCoin(tx.amount)}'
                                : Formatters.formatCoinWithSign(tx.amount),
                        style: AppTextStyles.titleMedium.copyWith(
                          color: _amountColor,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Bakiye: ${Formatters.formatCoin(tx.balance)}',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  // Chevron
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
          // Expanded detail
          if (_isExpanded) TransactionDetailRow(transaction: tx),
        ],
      ),
    );
  }
}
