import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/error/app_exception.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_error_widget.dart';
import '../../../core/widgets/empty_state_widget.dart';
import '../../../core/widgets/loading_shimmer.dart';
import '../../wallet/providers/wallet_providers.dart';
import '../data/models/campaign.dart';
import '../providers/store_providers.dart';
import 'widgets/campaign_card.dart';
import 'widgets/campaign_conflict_dialog.dart';
import 'widgets/coin_usage_selector.dart';

class StoreScreen extends ConsumerWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campaignsAsync = ref.watch(activeCampaignsProvider);
    final summaryAsync = ref.watch(walletSummaryProvider);
    final selectionState = ref.watch(storeSelectionNotifierProvider);

    final availableBalance = summaryAsync.valueOrNull?.availableBalance ?? 0;
    final hasSelection = selectionState.selectedCampaigns.isNotEmpty ||
        selectionState.coinAmount > 0;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Geri',
          onPressed: () => context.pop(),
          icon: const Icon(
            Icons.chevron_left,
            color: AppColors.textPrimary,
            size: 28,
          ),
        ),
        title: Text(
          'Mağaza Alışverişi',
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            tooltip: 'QR Kod Oluştur',
            onPressed: hasSelection
                ? () {
                    final state = ref.read(storeSelectionNotifierProvider);
                    context.push(
                      AppRoutes.payment,
                      extra: {
                        'coinAmount': state.coinAmount,
                        'campaignIds':
                            state.selectedCampaigns.map((c) => c.id).toList(),
                        'campaignNames':
                            state.selectedCampaigns.map((c) => c.name).toList(),
                      },
                    );
                  }
                : null,
            icon: Icon(
              Icons.qr_code,
              color: hasSelection ? AppColors.textPrimary : AppColors.disabled,
            ),
          ),
          IconButton(
            tooltip: 'Bildirimler',
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Coin selector
                  CoinUsageSelector(
                    availableBalance: availableBalance,
                    selectedPercentage: selectionState.coinPercentage,
                    coinAmount: selectionState.coinAmount,
                    onPercentageSelected: (pct) => ref
                        .read(storeSelectionNotifierProvider.notifier)
                        .selectCoinPercentage(pct, availableBalance),
                    onAmountChanged: (amount) => ref
                        .read(storeSelectionNotifierProvider.notifier)
                        .setCoinAmount(amount, availableBalance),
                  ),
                  if (selectionState.selectedCampaigns.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.md),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: selectionState.selectedCampaigns
                          .map(
                            (campaign) => Chip(
                              avatar: const Icon(
                                Icons.local_offer_outlined,
                                size: 16,
                                color: AppColors.primary,
                              ),
                              label: Text(campaign.name),
                              labelStyle: AppTextStyles.labelSmall.copyWith(
                                color: AppColors.textPrimary,
                              ),
                              backgroundColor: AppColors.cardBg,
                              side: BorderSide(
                                color: AppColors.primary.withValues(alpha: 0.2),
                              ),
                              onDeleted: () => ref
                                  .read(storeSelectionNotifierProvider.notifier)
                                  .toggleCampaign(campaign),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.lg),
                  // Campaigns header
                  Text(
                    'Kampanyalar',
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  // Campaign list
                  campaignsAsync.when(
                    loading: () => const LoadingShimmer(
                      itemCount: 3,
                      type: ShimmerType.card,
                    ),
                    error: (e, _) => AppErrorWidget(
                      message: e is AppException
                          ? e.userMessage
                          : 'Kampanyalar yüklenemedi.',
                      onRetry: () => ref.invalidate(activeCampaignsProvider),
                    ),
                    data: (campaigns) {
                      if (campaigns.isEmpty) {
                        return const EmptyStateWidget(
                          message: 'Aktif kampanya bulunamadı',
                          icon: Icons.local_offer_outlined,
                        );
                      }
                      return Column(
                        children: campaigns.map((campaign) {
                          final isSelected = selectionState.selectedCampaigns
                              .any((c) => c.id == campaign.id);
                          return CampaignCard(
                            campaign: campaign,
                            isSelected: isSelected,
                            onToggle: () => _handleToggle(
                              context,
                              ref,
                              campaign,
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          // Bottom CTA — uses AppButton from design system for consistency
          Container(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.md,
              AppSpacing.md,
              0,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: AppButton(
                icon: hasSelection ? Icons.qr_code : null,
                label: hasSelection ? 'QR Kod Oluştur' : 'Kampanyaları Seç',
                onPressed: hasSelection
                    ? () {
                        context.push(
                          AppRoutes.payment,
                          extra: {
                            'coinAmount': selectionState.coinAmount,
                            'campaignIds': selectionState.selectedCampaigns
                                .map((c) => c.id)
                                .toList(),
                            'campaignNames': selectionState.selectedCampaigns
                                .map((c) => c.name)
                                .toList(),
                          },
                        );
                      }
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleToggle(
    BuildContext context,
    WidgetRef ref,
    Campaign campaign,
  ) async {
    final conflict = ref
        .read(storeSelectionNotifierProvider.notifier)
        .toggleCampaign(campaign);

    if (conflict != null) {
      final confirmed = await CampaignConflictDialog.show(
        context,
        conflictType: conflict,
      );

      if (confirmed == true) {
        ref
            .read(storeSelectionNotifierProvider.notifier)
            .confirmConflictResolution();
      } else {
        ref.read(storeSelectionNotifierProvider.notifier).cancelConflict();
      }
    }
  }
}
