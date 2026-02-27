import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';

class LoyaltyLevelCard extends StatelessWidget {
  const LoyaltyLevelCard({required this.tierName, super.key});

  final String tierName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sadakat Seviyen:',
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.workspace_premium,
                    color: AppColors.coinGold,
                    size: 20,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    tierName,
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(color: AppColors.divider, height: 1),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.access_time_filled,
                    color: AppColors.negative,
                    size: 16,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Son Gün',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        '31 ARALIK',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Harcanan TL',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    '1.100 ₺',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          const _TierProgressBar(),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Seviye 2 sadakat kartının sunduğu ayrıcalıklar;',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.primary,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Avantaj: %5 indirim',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          RichText(
            text: TextSpan(
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
              children: [
                const TextSpan(text: 'Yükselme Kriteri: '),
                TextSpan(
                  text: 'Her ₺500 alışverişte ₺20 kupon',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
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

class _TierProgressBar extends StatelessWidget {
  const _TierProgressBar();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 28,
          child: Stack(
            children: [
              Positioned(
                top: 12,
                left: 0,
                right: 0,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.divider,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                left: 0,
                child: Container(
                  height: 4,
                  width: 80,
                  decoration: BoxDecoration(
                    color: AppColors.textPrimary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const Positioned(
                top: 6,
                left: 0,
                child: _MilestoneCheckpoint(isActive: true),
              ),
              const Positioned(
                top: 6,
                left: 70,
                child: _MilestoneCheckpoint(isActive: true),
              ),
              const Positioned(
                top: 6,
                right: 80,
                child: _MilestoneCheckpoint(isActive: false),
              ),
              const Positioned(
                top: 6,
                right: 0,
                child: _MilestoneCheckpoint(isActive: false),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _TierLabel(amount: '0', level: ''),
            _TierLabel(amount: '1.000 ₺', level: '(Seviye 2)'),
            _TierLabel(amount: '5.000 ₺', level: '(Seviye 3)'),
            _TierLabel(amount: '100.000 ₺', level: '(Seviye 4)'),
          ],
        ),
      ],
    );
  }
}

class _MilestoneCheckpoint extends StatelessWidget {
  const _MilestoneCheckpoint({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? AppColors.positive : AppColors.divider,
        border: Border.all(
          color: isActive
              ? AppColors.positive
              : AppColors.textSecondary.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: isActive
          ? const Icon(Icons.check, size: 10, color: Colors.white)
          : null,
    );
  }
}

class _TierLabel extends StatelessWidget {
  const _TierLabel({required this.amount, required this.level});

  final String amount;
  final String level;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          amount,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (level.isNotEmpty)
          Text(
            level,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textSecondary,
              fontSize: 9,
            ),
          ),
      ],
    );
  }
}
