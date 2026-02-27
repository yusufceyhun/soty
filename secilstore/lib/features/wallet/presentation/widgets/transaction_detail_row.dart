import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../data/models/transaction.dart';

class TransactionDetailRow extends StatelessWidget {
  const TransactionDetailRow({required this.transaction, super.key});

  final WalletTransaction transaction;

  @override
  Widget build(BuildContext context) {
    final details = _getDetails();
    if (details.isEmpty) return const SizedBox.shrink();

    return Container(
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
          ...details.map((detail) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (detail.label != null)
                      Text(
                        detail.label ?? '',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    Text(
                      detail.value,
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  List<_DetailItem> _getDetails() {
    final transactionType = transaction.transactionTypeName ?? '';
    return switch (transactionType) {
      'Görev Silindi' => [
          if (transaction.taskName != null)
            _DetailItem(value: transaction.taskName ?? ''),
          if (transaction.taskCategory != null)
            _DetailItem(value: transaction.taskCategory ?? ''),
        ],
      'Hediye' => [
          if (transaction.brandName != null)
            _DetailItem(label: 'Marka', value: transaction.brandName ?? ''),
        ],
      'Transfer' => [
          if (transaction.transferTo != null)
            _DetailItem(
              label: 'Transfer Edilen',
              value: transaction.transferTo ?? '',
            ),
        ],
      'İade' => [
          if (transaction.refundId != null)
            _DetailItem(label: 'İade No', value: transaction.refundId ?? ''),
        ],
      'Alışveriş' => [
          if (transaction.orderId != null)
            _DetailItem(label: 'Sipariş No', value: transaction.orderId ?? ''),
        ],
      'Görev' => [
          if (transaction.taskName != null)
            _DetailItem(value: transaction.taskName ?? ''),
          if (transaction.taskCategory != null)
            _DetailItem(value: transaction.taskCategory ?? ''),
        ],
      'Kampanya' => [
          if (transaction.campaignName != null)
            _DetailItem(value: transaction.campaignName ?? ''),
          if (transaction.campaignRule != null)
            _DetailItem(value: transaction.campaignRule ?? ''),
        ],
      _ => [],
    };
  }
}

class _DetailItem {
  const _DetailItem({this.label, required this.value});

  final String? label;
  final String value;
}
