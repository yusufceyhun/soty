import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/providers/core_providers.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/coin_icon.dart';
import '../../auth/providers/auth_providers.dart';
import '../../wallet/providers/wallet_providers.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(walletSummaryProvider);
    final userInfoAsync = ref.watch(_userInfoProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Profil',
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.md),
            // Avatar
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.1),
              ),
              child: const Icon(
                Icons.person,
                size: 40,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            // User name + email from JWT
            userInfoAsync.when(
              loading: () => const SizedBox(
                height: 40,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                    strokeWidth: 2,
                  ),
                ),
              ),
              error: (_, __) => Text(
                'Kullanıcı',
                style: AppTextStyles.headlineMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              data: (info) => Column(
                children: [
                  if (info.username != null)
                    Text(
                      info.username ?? '',
                      style: AppTextStyles.headlineMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (info.email != null) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      info.email ?? '',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                  if (info.phone != null) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      Formatters.formatPhone(info.phone ?? ''),
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            // Wallet summary card
            summaryAsync.whenOrNull(
                  data: (summary) => Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: AppColors.cardBg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.divider.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Balance
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CoinIcon(size: 28),
                            const SizedBox(width: AppSpacing.sm),
                            Text(
                              Formatters.formatCoin(summary.totalBalance),
                              style: AppTextStyles.headlineLarge.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          'Toplam Soty Coin',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          'Kullanılabilir Soty Coin: ${Formatters.formatCoin(summary.availableBalance)}',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                        if (summary.tierName != null) ...[
                          const SizedBox(height: AppSpacing.md),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                              vertical: AppSpacing.xs,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              summary.tierName ?? '',
                              style: AppTextStyles.labelLarge.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ) ??
                const SizedBox.shrink(),
            const SizedBox(height: AppSpacing.lg),
            // Menu items
            _ProfileMenuItem(
              icon: Icons.account_balance_wallet_outlined,
              label: 'Cüzdan',
              onTap: () => context.go(AppRoutes.wallet),
            ),
            _ProfileMenuItem(
              icon: Icons.storefront_outlined,
              label: 'Mağaza Alışverişi',
              onTap: () => context.push(AppRoutes.store),
            ),
            _ProfileMenuItem(
              icon: Icons.help_outline,
              label: 'Yardım & Destek',
              onTap: () {},
            ),
            _ProfileMenuItem(
              icon: Icons.info_outline,
              label: 'Hakkında',
              onTap: () {},
            ),
            const SizedBox(height: AppSpacing.lg),
            // Logout button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton.icon(
                onPressed: () async {
                  final confirmed = await showCupertinoDialog<bool>(
                    context: context,
                    builder: (ctx) => CupertinoAlertDialog(
                      title: const Text('Çıkış Yap'),
                      content: const Text(
                        'Hesabınızdan çıkış yapmak istediğinize emin misiniz?',
                      ),
                      actions: [
                        CupertinoDialogAction(
                          onPressed: () => ctx.pop(false),
                          child: const Text(
                            'İptal',
                            style: TextStyle(color: AppColors.textPrimary),
                          ),
                        ),
                        CupertinoDialogAction(
                          onPressed: () => ctx.pop(true),
                          isDestructiveAction: true,
                          child: const Text('Çıkış Yap'),
                        ),
                      ],
                    ),
                  );
                  if (confirmed == true) {
                    await ref.read(authRepositoryProvider).logout();
                    ref.invalidate(authStateProvider);
                  }
                },
                icon: const Icon(
                  Icons.logout,
                  color: AppColors.negative,
                  size: 20,
                ),
                label: Text(
                  'Çıkış Yap',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.negative,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.negative),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

// ─── User Info from JWT + Storage ─────────────────────────────────────────

class _UserInfo {
  const _UserInfo({this.username, this.email, this.phone});
  final String? username;
  final String? email;
  final String? phone;
}

final _userInfoProvider = FutureProvider<_UserInfo>((ref) async {
  final storage = ref.watch(secureStorageProvider);
  final token = await storage.getAccessToken();
  final phone = await storage.getPhone();

  String? username;
  String? email;

  if (token != null) {
    try {
      final parts = token.split('.');
      if (parts.length == 3) {
        final payload = parts[1];
        final normalized = base64Url.normalize(payload);
        final decoded = utf8.decode(base64Url.decode(normalized));
        final json = jsonDecode(decoded) as Map<String, dynamic>;
        username = json['preferred_username'] as String?;
        email = json['email'] as String?;
      }
    } catch (_) {
      // JWT decode failed — proceed with nulls
    }
  }

  return _UserInfo(username: username, email: email, phone: phone);
});

// ─── Menu Item ────────────────────────────────────────────────────────────

class _ProfileMenuItem extends StatelessWidget {
  const _ProfileMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.divider.withValues(alpha: 0.3),
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(icon, size: 22, color: AppColors.textSecondary),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right,
                size: 22,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
