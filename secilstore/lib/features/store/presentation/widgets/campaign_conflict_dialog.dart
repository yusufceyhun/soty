import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../data/models/campaign_selection_state.dart';

class CampaignConflictDialog extends StatelessWidget {
  const CampaignConflictDialog({
    required this.conflictType,
    required this.onConfirm,
    required this.onCancel,
    super.key,
  });

  final ConflictType conflictType;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  String get _message => switch (conflictType) {
        ConflictType.nonCombinableOverCombinables =>
          'Birleştirilemez kampanya seçerseniz, mevcut kampanyalar iptal edilecek. Devam etmek istiyor musunuz?',
        ConflictType.combinableOverNonCombinable =>
          'Birleştirilebilir kampanya seçerseniz, mevcut kampanya iptal edilecek. Devam etmek istiyor musunuz?',
      };

  static Future<bool?> show(
    BuildContext context, {
    required ConflictType conflictType,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => CampaignConflictDialog(
        conflictType: conflictType,
        onConfirm: () => Navigator.of(ctx).pop(true),
        onCancel: () => Navigator.of(ctx).pop(false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        'Kampanya Çakışması',
        style: AppTextStyles.titleLarge.copyWith(
          color: AppColors.textPrimary,
        ),
      ),
      content: Text(
        _message,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: Text(
            'İptal',
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text(
            'Devam Et',
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
