import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';

class CodeCountdownTimer extends StatefulWidget {
  const CodeCountdownTimer({
    required this.onExpired,
    this.onRefresh,
    super.key,
  });

  final VoidCallback onExpired;
  final VoidCallback? onRefresh;

  @override
  State<CodeCountdownTimer> createState() => CodeCountdownTimerState();
}

class CodeCountdownTimerState extends State<CodeCountdownTimer> {
  Timer? _timer;
  int _remaining = AppConstants.qrRefreshSecs;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void restart() {
    _timer?.cancel();
    if (!mounted) return;
    setState(() => _remaining = AppConstants.qrRefreshSecs);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _remaining--;
        if (_remaining <= 0) {
          timer.cancel();
          widget.onExpired();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final progress = _remaining / AppConstants.qrRefreshSecs;
    final isLow = _remaining <= 10;

    return Column(
      children: [
        // Circular progress
        SizedBox(
          width: 56,
          height: 56,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: progress,
                strokeWidth: 3,
                backgroundColor: AppColors.divider,
                valueColor: AlwaysStoppedAnimation(
                  isLow ? AppColors.negative : AppColors.primary,
                ),
              ),
              Text(
                '$_remaining',
                style: AppTextStyles.titleMedium.copyWith(
                  color: isLow ? AppColors.negative : AppColors.textPrimary,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'saniye',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        if (_remaining <= 0 && widget.onRefresh != null) ...[
          const SizedBox(height: AppSpacing.sm),
          GestureDetector(
            onTap: () {
              widget.onRefresh?.call();
              restart();
            },
            child: Text(
              'Yenile',
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.primary,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.primary,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
