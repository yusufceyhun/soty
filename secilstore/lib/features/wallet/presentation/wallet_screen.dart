import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/error/app_exception.dart';
import '../../../core/services/analytics_service.dart';
import '../../../core/services/remote_config_service.dart';
import '../../../core/widgets/app_error_widget.dart';
import '../../../core/widgets/empty_state_widget.dart';
import '../../../core/widgets/loading_shimmer.dart';
import '../data/wallet_repository.dart';
import '../providers/wallet_providers.dart';
import 'widgets/brand_row.dart';
import 'widgets/loyalty_level_card.dart';
import 'widgets/online_approval_banner.dart';
import 'widgets/pending_transaction_item.dart';
import 'widgets/shortcut_tile.dart';
import 'widgets/transaction_list_item.dart';
import 'widgets/transaction_tab_bar.dart';
import 'widgets/wallet_card_widget.dart';

class WalletScreen extends ConsumerStatefulWidget {
  const WalletScreen({super.key});

  @override
  ConsumerState<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends ConsumerState<WalletScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(AnalyticsService.logViewWallet());
    });
  }

  @override
  Widget build(BuildContext context) {
    final ref = this.ref;
    final summaryAsync = ref.watch(walletSummaryProvider);
    final tabIndex = ref.watch(walletTabNotifierProvider);
    final showOnlineShopping = RemoteConfigService.showOnlineShopping;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Cüzdan',
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'QR Kod Oluştur',
            onPressed: () => context.push(AppRoutes.store),
            icon: const Icon(Icons.qr_code, color: AppColors.textPrimary),
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
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async {
          ref.invalidate(walletSummaryProvider);
          final filter = switch (tabIndex) {
            0 => TransactionFilter.all,
            2 => TransactionFilter.earnings,
            3 => TransactionFilter.losses,
            _ => TransactionFilter.all,
          };
          if (tabIndex == 1) {
            ref.invalidate(pendingTransactionsDataProvider);
            ref.invalidate(pendingTransactionsProvider);
          } else {
            ref.invalidate(transactionsProvider(filter));
          }
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: AppSpacing.md),
                  // Wallet Card
                  summaryAsync.when(
                    loading: () => const LoadingShimmer(
                      itemCount: 1,
                      type: ShimmerType.walletCard,
                    ),
                    error: (e, _) => AppErrorWidget(
                      message: e is AppException
                          ? e.userMessage
                          : 'Cüzdan bilgileri yüklenemedi.',
                      onRetry: () => ref.invalidate(walletSummaryProvider),
                    ),
                    data: (summary) => WalletCardWidget(summary: summary),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  // Shortcut tiles (campaign counts from API)
                  summaryAsync.whenOrNull(
                        data: (summary) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                          ),
                          child: showOnlineShopping
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: ShortcutTile(
                                        icon: Icons.language,
                                        label: 'Online',
                                        labelBold: 'Alışveriş',
                                        campaignCount:
                                            summary.onlineCampaignCount,
                                        onTap: () {},
                                      ),
                                    ),
                                    const SizedBox(width: AppSpacing.md),
                                    Expanded(
                                      child: ShortcutTile(
                                        icon: Icons.storefront,
                                        label: 'Mağaza',
                                        labelBold: 'Alışverişi',
                                        campaignCount:
                                            summary.storeCampaignCount,
                                        onTap: () =>
                                            context.push(AppRoutes.store),
                                      ),
                                    ),
                                  ],
                                )
                              : ShortcutTile(
                                  icon: Icons.storefront,
                                  label: 'Mağaza',
                                  labelBold: 'Alışverişi',
                                  campaignCount: summary.storeCampaignCount,
                                  onTap: () => context.push(AppRoutes.store),
                                ),
                        ),
                      ) ??
                      const SizedBox.shrink(),
                  const SizedBox(height: AppSpacing.md),
                  // Brand row with SeçilStore logo from API
                  BrandRow(
                    brandLogoUrl: summaryAsync.valueOrNull?.brandLogo,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  // Loyalty level card — only show if tier data exists
                  if (summaryAsync.valueOrNull?.tierName != null)
                    LoyaltyLevelCard(
                      tierName: summaryAsync.valueOrNull?.tierName ?? '',
                    ),
                  const SizedBox(height: AppSpacing.md),
                  // Tab Bar
                  TransactionTabBar(
                    selectedIndex: tabIndex,
                    onTabSelected: (index) => ref
                        .read(walletTabNotifierProvider.notifier)
                        .selectTab(index),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ],
              ),
            ),
            // Tab Content
            _SliverTabContent(tabIndex: tabIndex),
          ],
        ),
      ),
    );
  }
}

class _SliverTabContent extends ConsumerWidget {
  const _SliverTabContent({required this.tabIndex});

  final int tabIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (tabIndex == 1) {
      return _SliverPendingTab();
    }

    final filter = switch (tabIndex) {
      0 => TransactionFilter.all,
      2 => TransactionFilter.earnings,
      3 => TransactionFilter.losses,
      _ => TransactionFilter.all,
    };

    final txAsync = ref.watch(transactionsProvider(filter));

    return txAsync.when(
      loading: () => const SliverToBoxAdapter(
        child: LoadingShimmer(itemCount: 5),
      ),
      error: (e, _) => SliverToBoxAdapter(
        child: AppErrorWidget(
          message: e is AppException ? e.userMessage : 'İşlemler yüklenemedi.',
          onRetry: () => ref.invalidate(transactionsProvider(filter)),
        ),
      ),
      data: (transactions) {
        if (transactions.isEmpty) {
          final emptyMessage = switch (tabIndex) {
            2 => 'Henüz kazanımınız yok',
            3 => 'Henüz harcamanız yok',
            _ => 'Henüz işlem geçmişiniz yok',
          };
          return SliverToBoxAdapter(
            child: EmptyStateWidget(message: emptyMessage),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) =>
                TransactionListItem(transaction: transactions[index]),
            childCount: transactions.length,
          ),
        );
      },
    );
  }
}

class _SliverPendingTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingAsync = ref.watch(pendingTransactionsDataProvider);

    return pendingAsync.when(
      loading: () => const SliverToBoxAdapter(
        child: LoadingShimmer(itemCount: 3),
      ),
      error: (e, _) => SliverToBoxAdapter(
        child: AppErrorWidget(
          message: e is AppException
              ? e.userMessage
              : 'Bekleyen işlemler yüklenemedi.',
          onRetry: () => ref.invalidate(pendingTransactionsDataProvider),
        ),
      ),
      data: (pendingData) {
        final items = pendingData.items;

        return SliverList(
          delegate: SliverChildListDelegate(
            [
              OnlineApprovalBanner(
                approvalDurationDays: pendingData.approvalDurationDays,
              ),
              if (items.isEmpty)
                const EmptyStateWidget(
                  message: 'Bekleyen işleminiz bulunmuyor',
                )
              else
                ...items.map((tx) => PendingTransactionItem(transaction: tx)),
            ],
          ),
        );
      },
    );
  }
}
