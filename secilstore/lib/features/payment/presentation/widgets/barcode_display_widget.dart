import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';

class BarcodeDisplayWidget extends StatelessWidget {
  const BarcodeDisplayWidget({required this.data, super.key});

  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider.withValues(alpha: 0.5)),
      ),
      child: BarcodeWidget(
        barcode: Barcode.code128(),
        data: data,
        width: double.infinity,
        height: 80,
        drawText: true,
        style: const TextStyle(
          fontSize: 12,
          color: AppColors.textPrimary,
          letterSpacing: 2,
        ),
      ),
    );
  }
}
