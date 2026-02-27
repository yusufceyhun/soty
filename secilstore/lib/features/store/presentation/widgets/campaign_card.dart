import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../data/models/campaign.dart';

class CampaignCard extends StatelessWidget {
  const CampaignCard({
    required this.campaign,
    required this.isSelected,
    required this.onToggle,
    super.key,
  });

  final Campaign campaign;
  final bool isSelected;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final isActive = campaign.isActive;

    return Opacity(
      opacity: isActive ? 1.0 : 0.4,
      child: IgnorePointer(
        ignoring: !isActive,
        child: Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.md),
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? AppColors.primary
                  : AppColors.divider.withValues(alpha: 0.3),
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row: SecilStore logo + combinable badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Brand logo
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: campaign.brandLogoUrl != null &&
                            campaign.brandLogoUrl!.isNotEmpty
                        ? Image.network(
                            campaign.brandLogoUrl!,
                            height: 32,
                            width: 88,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                              Icons.storefront_outlined,
                              color: AppColors.textSecondary,
                            ),
                          )
                        : const Icon(
                            Icons.storefront_outlined,
                            color: AppColors.textSecondary,
                          ),
                  ),
                  // Combinable badge with ⓘ icon
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.info_outline,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        campaign.isCombinable
                            ? 'Birleştirilebilir'
                            : 'Birleştirilemez',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              // Campaign title (bold)
              Text(
                campaign.name,
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if ((campaign.discountLabel ?? '').isNotEmpty) ...[
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    const Icon(
                      Icons.local_offer,
                      size: 14,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Text(
                        campaign.discountLabel!,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primaryDark,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              // Description with "Açıklama:" prefix
              if (campaign.description.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.xs),
                RichText(
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    children: [
                      TextSpan(
                        text: 'Açıklama: ',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: campaign.description),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.md),
              // Bottom row: end date (left) + Seç/Seçildi button (right)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // End date
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        campaign.endDate.year <= 1
                            ? 'Geçerlilik: Belirtilmedi'
                            : 'Geçerlilik: ${DateFormat('dd.MM.yyyy', 'tr_TR').format(campaign.endDate)}',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  // Select button (compact)
                  SizedBox(
                    height: 36,
                    child: isSelected
                        ? ElevatedButton(
                            onPressed: onToggle,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.lg,
                              ),
                            ),
                            child: Text(
                              'Seçildi ✓',
                              style: AppTextStyles.labelLarge.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : OutlinedButton(
                            onPressed: onToggle,
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: AppColors.primary,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.lg,
                              ),
                            ),
                            child: Text(
                              'Seç',
                              style: AppTextStyles.labelLarge.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
