import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/error/app_exception.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_button.dart';
import '../providers/auth_providers.dart';
import 'widgets/otp_input_row.dart';

class OtpScreen extends ConsumerStatefulWidget {
  const OtpScreen({required this.phone, super.key});

  final String phone;

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final _otpKey = GlobalKey<OtpInputRowState>();
  Timer? _timer;
  int _remainingSeconds = AppConstants.otpTimerSecs;
  bool _isExpired = false;
  String? _errorMessage;
  bool _isVerifying = false;
  String _enteredCode = '';

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

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _remainingSeconds = AppConstants.otpTimerSecs;
      _isExpired = false;
      _errorMessage = null;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _remainingSeconds--;
        if (_remainingSeconds <= 0) {
          _isExpired = true;
          _errorMessage = 'Doğrulama kodu süresi doldu';
          timer.cancel();
        }
      });
    });
  }

  String get _formattedTime {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  Future<void> _onOtpCompleted(String code) async {
    setState(() => _enteredCode = code);
    if (_isVerifying) return;

    setState(() {
      _isVerifying = true;
      _errorMessage = null;
    });

    final success = await ref
        .read(loginNotifierProvider.notifier)
        .verifyOtp(widget.phone, code);

    if (success && mounted) {
      context.go(AppRoutes.wallet);
      return;
    }

    if (mounted) {
      final loginState = ref.read(loginNotifierProvider);
      final error = loginState.error;
      if (error is AppException) {
        setState(() {
          _errorMessage = error.userMessage;
          _isVerifying = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Doğrulama kodu yanlış.';
          _isVerifying = false;
        });
      }
      _otpKey.currentState?.clear();
    }
  }

  Future<void> _onResend() async {
    ref.read(loginNotifierProvider.notifier).clearError();
    final success =
        await ref.read(loginNotifierProvider.notifier).requestOtp(widget.phone);

    if (success && mounted) {
      _otpKey.currentState?.clear();
      _startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginNotifierProvider);
    final isLoading = loginState.isLoading || _isVerifying;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.lg,
          ),
          child: Column(
            children: [
              // Back button
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  tooltip: 'Geri',
                  onPressed: () => context.pop(),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              // Soty Logo
              Image.asset(
                'assets/logo.png',
                height: 80,
              ),
              const SizedBox(height: AppSpacing.xl),
              // Phone display
              Text(
                Formatters.formatPhone(widget.phone),
                style: AppTextStyles.headlineLarge.copyWith(
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Doğrulama kodunu telefonunuza gönderildi',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl),
              // Label — centered per mockup
              Text(
                'Doğrulama Kodu',
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
              // OTP Input
              OtpInputRow(
                key: _otpKey,
                onCompleted: _onOtpCompleted,
                onChanged: (code) => setState(() => _enteredCode = code),
                hasError: _errorMessage != null,
              ),
              const SizedBox(height: AppSpacing.md),
              // Error message
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.negative,
                  ),
                  textAlign: TextAlign.center,
                ),
              // Resend link
              if (_isExpired)
                Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.sm),
                  child: GestureDetector(
                    onTap: _onResend,
                    child: Text(
                      'Tekrar Gönder',
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: AppSpacing.sm),
              // Timer
              Text(
                _formattedTime,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(),
              // Verify Button
              AppButton(
                label: 'Doğrula',
                isLoading: isLoading,
                onPressed: _enteredCode.length == 6 && !isLoading
                    ? () => _onOtpCompleted(_enteredCode)
                    : null,
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}
