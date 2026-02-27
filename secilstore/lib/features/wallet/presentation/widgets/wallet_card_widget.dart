import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/coin_icon.dart';
import '../../data/models/wallet_summary.dart';

class WalletCardWidget extends StatefulWidget {
  const WalletCardWidget({required this.summary, super.key});

  final WalletSummary summary;

  static const double _cardHeight = 200;
  static const double _cardRadius = 20;
  static const double _peekHeight = 36;
  // Only 2 real pages in PageView (SecilStore + ILMIO)
  static const int _cardCount = 2;

  @override
  State<WalletCardWidget> createState() => _WalletCardWidgetState();
}

class _WalletCardWidgetState extends State<WalletCardWidget> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const totalHeight =
        WalletCardWidget._cardHeight + WalletCardWidget._peekHeight;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: SizedBox(
        height: totalHeight,
        child: Row(
          children: [
            // ── Cards area ─────────────────────────────────────────
            Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Back card peek – grey gradient (ILMIO peek)
                  Positioned(
                    top: 0,
                    left: 12,
                    right: 12,
                    child: Container(
                      height: WalletCardWidget._peekHeight,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(WalletCardWidget._cardRadius),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF9E9E9E), Color(0xFF757575)],
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            right: AppSpacing.md,
                          ),
                          child: Image.asset(
                            'assets/ilmio_logo.png',
                            height: 14,
                            color: Colors.white.withValues(alpha: 0.8),
                            colorBlendMode: BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // PageView (front card) – sits below the peek
                  Positioned(
                    top: WalletCardWidget._peekHeight,
                    left: 0,
                    right: 0,
                    height: WalletCardWidget._cardHeight,
                    child: GestureDetector(
                      onVerticalDragUpdate: (_) {}, // prevent scroll hijack
                      child: PageView(
                        controller: _pageController,
                        physics: const BouncingScrollPhysics(),
                        onPageChanged: (index) =>
                            setState(() => _currentPage = index),
                        children: [
                          _WalletCard(
                            summary: widget.summary,
                            // SecilStore – uses bronze gradient + walletCover
                            gradientColors: const [
                              Color(0xFFD4A574),
                              Color(0xFFC4956A),
                              Color(0xFFB5855A),
                            ],
                            logoAsset: 'assets/secilstore_logo.png',
                            logoUrl: widget.summary.walletLogo,
                            coverUrl: widget.summary.walletCover,
                          ),
                          _WalletCard(
                            summary: widget.summary,
                            // ILMIO – uses grey gradient
                            gradientColors: const [
                              Color(0xFFAAAAAA),
                              Color(0xFF8E8E8E),
                              Color(0xFF6E6E6E),
                            ],
                            logoAsset: 'assets/ilmio_logo.png',
                            // ILMIO card uses local asset only (no separate walletLogo for ILMIO)
                            logoUrl: null,
                            coverUrl: null,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            // ── Dot indicators (vertical, right side) ─────────────
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(WalletCardWidget._cardCount, (index) {
                final isActive = index == _currentPage;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive
                          ? AppColors.textPrimary
                          : AppColors.textSecondary.withValues(alpha: 0.3),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Shared wallet card widget ─────────────────────────────────────────────
// Eliminates the previous copy-paste duplication between _SecilStoreCard
// and _IlmioFullCard — they had 95% identical layout.

class _WalletCard extends StatelessWidget {
  const _WalletCard({
    required this.summary,
    required this.gradientColors,
    required this.logoAsset,
    this.logoUrl,
    this.coverUrl,
  });

  final WalletSummary summary;
  final List<Color> gradientColors;

  /// Local asset path (fallback)
  final String logoAsset;

  /// Remote URL for brand logo shown on card (optional)
  final String? logoUrl;

  /// Remote URL for card background image (optional)
  final String? coverUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(WalletCardWidget._cardRadius),
        // Gradient is always rendered — cover image is overlaid on top
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(WalletCardWidget._cardRadius),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ── Background cover image (from API) ─────────────────
            if (coverUrl != null)
              Positioned.fill(
                child: Image.network(
                  coverUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                ),
              ),
            // ── Subtle dark overlay for legibility ─────────────────
            if (coverUrl != null)
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.08),
                        Colors.black.withValues(alpha: 0.30),
                      ],
                    ),
                  ),
                ),
              ),
            // ── Card content ────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo – top right
                  Align(
                    alignment: Alignment.topRight,
                    child: _CardLogo(
                      logoUrl: logoUrl,
                      logoAsset: logoAsset,
                    ),
                  ),
                  const Spacer(),
                  // Coin icon + balance – centred
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CoinIcon(size: 36),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        Formatters.formatCoin(summary.totalBalance),
                        style: AppTextStyles.displayLarge.copyWith(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Bottom row: tier name + exchange rate
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        summary.tierName ?? 'Bronz Kart',
                        style: AppTextStyles.titleMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '1 Soty Coin = 1 ₺',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Colors.white.withValues(alpha: 0.85),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Card logo widget ──────────────────────────────────────────────────────
class _CardLogo extends StatelessWidget {
  const _CardLogo({required this.logoUrl, required this.logoAsset});

  final String? logoUrl;
  final String logoAsset;

  @override
  Widget build(BuildContext context) {
    final hasRemoteLogo = (logoUrl ?? '').isNotEmpty;
    if (hasRemoteLogo) {
      return Image.network(
        logoUrl ?? '',
        height: 28,
        fit: BoxFit.contain,
        color: Colors.white.withValues(alpha: 0.9),
        colorBlendMode: BlendMode.srcIn,
        errorBuilder: (_, __, ___) => _assetLogo(),
      );
    }
    return _assetLogo();
  }

  Widget _assetLogo() => Image.asset(
        logoAsset,
        height: 28,
        color: Colors.white.withValues(alpha: 0.85),
        colorBlendMode: BlendMode.srcIn,
      );
}
