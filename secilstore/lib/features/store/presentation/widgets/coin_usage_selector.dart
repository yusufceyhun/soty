import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';

class CoinUsageSelector extends StatelessWidget {
  const CoinUsageSelector({
    required this.availableBalance,
    required this.selectedPercentage,
    required this.coinAmount,
    required this.onPercentageSelected,
    super.key,
  });

  final double availableBalance;
  final int? selectedPercentage;
  final double coinAmount;
  final ValueChanged<int> onPercentageSelected;

  static const _percentages = [25, 50, 75, 100];

  bool get _isDisabled => availableBalance <= 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.divider.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title row: "Soty Coin Kullan" + "Toplam Bakiye: X"
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Soty Coin Kullan',
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Kullanılabilir: ${Formatters.formatCoin(availableBalance)}',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Kullanmak istediğiniz toplam Soty Coin miktarının yüzdesini seçiniz.',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          if (_isDisabled) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Kullanılabilir bakiyeniz yetersiz olduğu için coin seçimi yapılamaz.',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.negative,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          // Amount input + percentage chips
          Row(
            children: [
              // Amount display field
              Expanded(
                flex: 2,
                child: Container(
                  height: 44,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Text(
                    coinAmount > 0
                        ? Formatters.formatCoin(coinAmount)
                        : 'Miktar Giriniz',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: coinAmount > 0
                          ? AppColors.textPrimary
                          : AppColors.textSecondary.withValues(alpha: 0.5),
                      fontWeight:
                          coinAmount > 0 ? FontWeight.w600 : FontWeight.normal,
                      fontFeatures: coinAmount > 0
                          ? const [FontFeature.tabularFigures()]
                          : null,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              // Percentage chips (circular pill style)
              ...List.generate(_percentages.length, (i) {
                final pct = _percentages[i];
                final isSelected = selectedPercentage == pct;
                return Padding(
                  padding: EdgeInsets.only(
                    left: i > 0 ? AppSpacing.xs : 0,
                  ),
                  child: GestureDetector(
                    onTap: _isDisabled ? null : () => onPercentageSelected(pct),
                    child: Container(
                      width: 44,
                      height: 44,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                        border: Border.all(
                          color: isSelected && !_isDisabled
                              ? AppColors.primary
                              : _isDisabled
                                  ? AppColors.disabled
                                  : AppColors.inputBorder,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Text(
                        '%$pct',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: isSelected && !_isDisabled
                              ? AppColors.primary
                              : _isDisabled
                                  ? AppColors.disabled
                                  : AppColors.textPrimary,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
