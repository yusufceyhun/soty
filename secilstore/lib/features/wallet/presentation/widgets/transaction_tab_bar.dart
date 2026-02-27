import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';

class TransactionTabBar extends StatelessWidget {
  const TransactionTabBar({
    required this.selectedIndex,
    required this.onTabSelected,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  static const _tabs = ['Tümü', 'Bekleyen', 'Kazandıklarım', 'Harcadıklarım'];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.xs),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(_tabs.length, (index) {
            final isSelected = index == selectedIndex;
            return GestureDetector(
              onTap: () => onTabSelected(index),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isSelected ? AppColors.surface : Colors.transparent,
                  border: isSelected
                      ? Border.all(
                          color: AppColors.primary.withValues(alpha: 0.3))
                      : null,
                ),
                child: Text(
                  _tabs[index],
                  style: (isSelected
                          ? AppTextStyles.labelLarge
                          : AppTextStyles.bodyMedium)
                      .copyWith(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textSecondary,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
