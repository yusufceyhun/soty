import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';

class BrandRow extends StatelessWidget {
  const BrandRow({
    this.brandLogoUrl,
    super.key,
  });

  /// Brand logo URL from API (optional — falls back to local asset)
  final String? brandLogoUrl;

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
      child: Row(
        children: [
          _BrandLogo(logoUrl: brandLogoUrl),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SeçilStore Marka Sayfası',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'SeçilStore kampanyalarını keşfet',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward,
            color: AppColors.textSecondary,
            size: 20,
          ),
        ],
      ),
    );
  }
}

class _BrandLogo extends StatelessWidget {
  const _BrandLogo({this.logoUrl});

  final String? logoUrl;

  @override
  Widget build(BuildContext context) {
    final hasRemoteLogo = (logoUrl ?? '').isNotEmpty;

    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.divider),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: hasRemoteLogo
              ? Image.network(
                  logoUrl ?? '',
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => _assetLogo(),
                )
              : _assetLogo(),
        ),
      ),
    );
  }

  Widget _assetLogo() => Image.asset(
        'assets/secilstore_logo.png',
        fit: BoxFit.contain,
      );
}
