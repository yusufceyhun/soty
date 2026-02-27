import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/models/country_code.dart';
import 'country_code_picker.dart';

class PhoneInputField extends StatelessWidget {
  const PhoneInputField({
    required this.controller,
    required this.onChanged,
    required this.selectedCountry,
    required this.onCountryChanged,
    this.errorText,
    super.key,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final CountryCode selectedCountry;
  final ValueChanged<CountryCode> onCountryChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CountryCodePicker(
              selectedCountry: selectedCountry,
              onChanged: onCountryChanged,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: SizedBox(
                height: 52,
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.phone,
                  maxLength: selectedCountry.maxLength,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: onChanged,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: '555 555 55 55',
                    hintStyle: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textSecondary.withValues(alpha: 0.5),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.md,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.inputBorder,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.inputBorder,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 1.5,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.negative,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        if (errorText != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Padding(
            padding: const EdgeInsets.only(left: AppSpacing.sm),
            child: Text(
              errorText!,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.negative,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
