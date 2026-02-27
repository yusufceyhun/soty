import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';

class TransactionCountdownTimer extends StatefulWidget {
  const TransactionCountdownTimer({
    required this.estimatedDate,
    this.onExpire,
    super.key,
  });

  final DateTime estimatedDate;
  final VoidCallback? onExpire;

  @override
  State<TransactionCountdownTimer> createState() =>
      _TransactionCountdownTimerState();
}

class _TransactionCountdownTimerState extends State<TransactionCountdownTimer> {
  Timer? _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _calculateRemaining();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _calculateRemaining();
    });
  }

  void _calculateRemaining() {
    final now = DateTime.now();
    final difference = widget.estimatedDate.difference(now);

    if (difference.isNegative && !_remaining.isNegative) {
      // Transitioned to expired
      setState(() => _remaining = difference);
      _timer?.cancel();
      widget.onExpire?.call();
    } else if (!difference.isNegative) {
      setState(() => _remaining = difference);
    } else {
      _remaining = difference; // Already expired
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isExpired = _remaining.isNegative;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isExpired
            ? AppColors.negative.withValues(alpha: 0.1)
            : AppColors.pending.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        Formatters.formatDurationTimer(_remaining),
        style: AppTextStyles.labelSmall.copyWith(
          color: isExpired ? AppColors.negative : AppColors.pending,
          fontWeight: FontWeight.bold,
          fontFeatures: const [FontFeature.tabularFigures()],
        ),
      ),
    );
  }
}
