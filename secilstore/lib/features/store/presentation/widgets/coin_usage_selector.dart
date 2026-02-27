import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';

class CoinUsageSelector extends StatefulWidget {
  const CoinUsageSelector({
    required this.availableBalance,
    required this.selectedPercentage,
    required this.coinAmount,
    required this.onPercentageSelected,
    required this.onAmountChanged,
    super.key,
  });

  final double availableBalance;
  final int? selectedPercentage;
  final double coinAmount;
  final ValueChanged<int> onPercentageSelected;
  final ValueChanged<double> onAmountChanged;

  @override
  State<CoinUsageSelector> createState() => _CoinUsageSelectorState();
}

class _CoinUsageSelectorState extends State<CoinUsageSelector> {
  static const _percentages = [25, 50, 75, 100];

  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _inputExceeded = false;

  bool get _isDisabled => widget.availableBalance <= 0;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.coinAmount > 0 ? widget.coinAmount.toInt().toString() : '',
    );
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(covariant CoinUsageSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_focusNode.hasFocus) return;
    final nextText =
        widget.coinAmount > 0 ? widget.coinAmount.toInt().toString() : '';
    if (_controller.text != nextText) {
      _controller.value = TextEditingValue(
        text: nextText,
        selection: TextSelection.collapsed(offset: nextText.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.divider.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Soty Coin Kullan',
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Kullanılabilir: ${Formatters.formatCoin(widget.availableBalance)}',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Kullanmak istediğiniz toplam Soty Coin miktarının yüzdesini seçiniz.',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          if (_isDisabled) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Kullanılabilir bakiyeniz yetersiz olduğu için coin seçimi yapılamaz.',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.negative,
              ),
            ),
          ],
          if (_inputExceeded) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Girilen coin miktarı kullanılabilir bakiyeyi aşamaz.',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.negative,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 44,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    enabled: !_isDisabled,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) {
                      final parsed = double.tryParse(value) ?? 0;
                      final exceeded = parsed > widget.availableBalance;
                      if (exceeded != _inputExceeded) {
                        setState(() => _inputExceeded = exceeded);
                      }
                      widget.onAmountChanged(parsed);
                    },
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Miktar Giriniz',
                      hintStyle: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary.withValues(alpha: 0.5),
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.sm,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              ...List.generate(_percentages.length, (i) {
                final pct = _percentages[i];
                final isSelected = widget.selectedPercentage == pct;
                return Padding(
                  padding: EdgeInsets.only(
                    left: i > 0 ? AppSpacing.xs : 0,
                  ),
                  child: GestureDetector(
                    onTap: _isDisabled
                        ? null
                        : () {
                            if (_inputExceeded) {
                              setState(() => _inputExceeded = false);
                            }
                            widget.onPercentageSelected(pct);
                            FocusScope.of(context).unfocus();
                          },
                    child: Container(
                      width: 44,
                      height: 44,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                        border: Border.all(
                          color: isSelected && !_isDisabled
                              ? AppColors.primary
                              : _isDisabled
                                  ? AppColors.disabled
                                  : AppColors.inputBorder,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Text(
                        '%$pct',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: isSelected && !_isDisabled
                              ? AppColors.primary
                              : _isDisabled
                                  ? AppColors.disabled
                                  : AppColors.textPrimary,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
