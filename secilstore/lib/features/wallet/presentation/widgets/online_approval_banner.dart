import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';

class OnlineApprovalBanner extends StatelessWidget {
  const OnlineApprovalBanner({
    required this.approvalDurationDays,
    super.key,
  });

  final int approvalDurationDays;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.pending.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.pending.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.schedule, color: AppColors.pending, size: 28),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Online Sepet Onaylama Süresi',
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '$approvalDurationDays Gün',
                  style: AppTextStyles.titleLarge.copyWith(
                    color: AppColors.pending,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
