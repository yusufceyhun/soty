import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/error/app_exception.dart';
import '../../../core/models/country_code.dart';
import '../../../core/widgets/app_button.dart';
import '../providers/auth_providers.dart';
import 'widgets/phone_input_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _phoneController = TextEditingController();
  CountryCode _selectedCountry = CountryCode.turkey;
  bool _showValidation = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  bool get _isPhoneValid {
    final digits = _phoneController.text.replaceAll(RegExp(r'[^\d]'), '');
    if (digits.isEmpty) return false;
    return digits.length >= _selectedCountry.minLength &&
        digits.length <= _selectedCountry.maxLength;
  }

  String get _normalizedPhone {
    final digits = _phoneController.text.replaceAll(RegExp(r'[^\d]'), '');
    return '${_selectedCountry.dialCode}$digits';
  }

  Future<void> _onSubmit() async {
    setState(() => _showValidation = true);

    if (!_isPhoneValid) return;

    final phone = _normalizedPhone;
    final success =
        await ref.read(loginNotifierProvider.notifier).requestOtp(phone);

    if (success && mounted) {
      context.push(AppRoutes.otp, extra: phone);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginNotifierProvider);
    final isLoading = loginState.isLoading;

    ref.listen(loginNotifierProvider, (prev, next) {
      final error = next.error;
      if (error is AppException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.userMessage),
            backgroundColor: AppColors.negative,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    });

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
                  onPressed: () => context.go(AppRoutes.splash),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              // Soty Logo
              Image.asset(
                'assets/logo.png',
                height: 120,
              ),
              const SizedBox(height: AppSpacing.xxl),
              // Title
              Text(
                'Tekrar Hoş Geldiniz',
                style: AppTextStyles.headlineLarge.copyWith(
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              // Subtitle
              Text(
                'Lütfen telefon numaranız ile giriş yapınız',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl),
              // Phone Input
              PhoneInputField(
                controller: _phoneController,
                selectedCountry: _selectedCountry,
                onCountryChanged: (country) {
                  setState(() => _selectedCountry = country);
                },
                onChanged: (_) => setState(() {}),
                errorText: _showValidation && !_isPhoneValid
                    ? 'Telefon numaranız hatalı.'
                    : null,
              ),
              const Spacer(),
              // Submit Button
              AppButton(
                label: 'Giriş Yap',
                isLoading: isLoading,
                onPressed: _isPhoneValid && !isLoading ? _onSubmit : null,
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}
