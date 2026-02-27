import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/models/country_code.dart';

class CountryCodePicker extends StatelessWidget {
  const CountryCodePicker({
    required this.selectedCountry,
    required this.onChanged,
    super.key,
  });

  final CountryCode selectedCountry;
  final ValueChanged<CountryCode> onChanged;

  void _showPicker(BuildContext context) {
    const countries = CountryCode.all;
    int selectedIndex = countries.indexWhere(
      (c) => c.code == selectedCountry.code,
    );
    if (selectedIndex < 0) selectedIndex = 0;

    showCupertinoModalPopup<void>(
      context: context,
      builder: (ctx) {
        int tempIndex = selectedIndex;
        return Material(
          color: Colors.transparent,
          child: Container(
            height: 320,
            decoration: const BoxDecoration(
              color: CupertinoColors.systemBackground,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              children: [
                // Top bar with Done button
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppColors.divider),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: Text(
                          'İptal',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                      Text(
                        'Ülke Seçin',
                        style: AppTextStyles.titleMedium.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          onChanged(countries[tempIndex]);
                          Navigator.of(ctx).pop();
                        },
                        child: Text(
                          'Tamam',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Cupertino picker
                Expanded(
                  child: CupertinoPicker(
                    scrollController: FixedExtentScrollController(
                      initialItem: selectedIndex,
                    ),
                    magnification: 1.1,
                    squeeze: 1.2,
                    itemExtent: 40,
                    onSelectedItemChanged: (index) {
                      tempIndex = index;
                    },
                    children: countries.map((country) {
                      return Center(
                        child: Text(
                          '${country.flag}  ${country.name} (+${country.dialCode})',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showPicker(context),
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.inputBorder),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              selectedCountry.flag,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(width: 4),
            Text(
              selectedCountry.displayDialCode,
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 2),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 18,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
