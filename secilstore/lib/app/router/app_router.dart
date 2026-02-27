import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/constants/app_colors.dart';
import '../../core/providers/core_providers.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/otp_screen.dart';
import '../../features/auth/presentation/splash_screen.dart';
import '../../features/auth/providers/auth_providers.dart';
import '../../features/home/presentation/home_shell.dart';
import '../../features/home/presentation/placeholder_screen.dart';
import '../../features/payment/presentation/payment_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/store/presentation/store_screen.dart';
import '../../features/wallet/presentation/wallet_screen.dart';

part 'app_router.g.dart';

const _enableRouterLogs =
    bool.fromEnvironment('ENABLE_ROUTER_LOGS', defaultValue: false);

class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String login = '/login';
  static const String otp = '/otp';
  static const String feed = '/feed';
  static const String tasks = '/tasks';
  static const String wallet = '/wallet';
  static const String campaigns = '/campaigns';
  static const String profile = '/profile';
  static const String store = '/store';
  static const String payment = '/payment';
}

final rootNavigatorKey = GlobalKey<NavigatorState>();
final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

@riverpod
GoRouter appRouter(Ref ref) {
  // Set up the callback for 401 Unauthorized handling from AuthInterceptor
  Future.microtask(() {
    ref.read(authRedirectCallbackProvider.notifier).state = () {
      ref.invalidate(authStateProvider);
      scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(
          content:
              Text('Oturum süreniz dolmuştur. Lütfen tekrar giriş yapınız.'),
          backgroundColor: AppColors.negative,
          behavior: SnackBarBehavior.floating,
        ),
      );
      rootNavigatorKey.currentContext?.go(AppRoutes.login);
    };
  });

  // Watch auth state to rebuild router when auth changes
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: kDebugMode && _enableRouterLogs,
    redirect: (BuildContext context, GoRouterState state) {
      if (authState.isLoading) {
        return null;
      }

      final isLoggedIn = authState.valueOrNull ?? false;
      final currentLocation = state.matchedLocation;
      final onAuthRoute = currentLocation == AppRoutes.splash ||
          currentLocation == AppRoutes.login ||
          currentLocation == AppRoutes.otp;

      if (isLoggedIn && onAuthRoute) {
        return AppRoutes.wallet;
      }

      if (!isLoggedIn && !onAuthRoute) {
        return AppRoutes.login;
      }

      return null;
    },
    routes: [
      // Auth routes (no bottom nav)
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.otp,
        builder: (context, state) {
          final extra = state.extra;
          final phone = extra is String ? extra : '';
          return OtpScreen(phone: phone);
        },
      ),
      // Main app shell with bottom navigation
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HomeShell(navigationShell: navigationShell);
        },
        branches: [
          // Branch 0: Akış
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.feed,
                builder: (context, state) => const PlaceholderScreen(
                  title: 'Akış',
                  icon: Icons.home,
                ),
              ),
            ],
          ),
          // Branch 1: Görev
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.tasks,
                builder: (context, state) => const PlaceholderScreen(
                  title: 'Görev',
                  icon: Icons.description,
                ),
              ),
            ],
          ),
          // Branch 2: Wallet (main feature)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.wallet,
                builder: (context, state) => const WalletScreen(),
              ),
            ],
          ),
          // Branch 3: Kampanya
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.campaigns,
                builder: (context, state) => const PlaceholderScreen(
                  title: 'Kampanya',
                  icon: Icons.explore,
                ),
              ),
            ],
          ),
          // Branch 4: Profil
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      // Full-screen routes (pushed on top of shell)
      GoRoute(
        path: AppRoutes.store,
        builder: (context, state) => const StoreScreen(),
      ),
      GoRoute(
        path: AppRoutes.payment,
        builder: (context, state) {
          final stateExtra = state.extra;
          final extra = stateExtra is Map<String, dynamic>
              ? stateExtra
              : const <String, dynamic>{};
          final coinAmount = extra['coinAmount'];
          final campaignIds = extra['campaignIds'];
          final campaignNames = extra['campaignNames'];
          return PaymentScreen(
            coinAmount: coinAmount is num ? coinAmount.toDouble() : null,
            campaignIds: campaignIds is List
                ? campaignIds
                    .whereType<Object>()
                    .map((e) => e.toString())
                    .toList()
                : const <String>[],
            campaignNames: campaignNames is List
                ? campaignNames
                    .whereType<Object>()
                    .map((e) => e.toString())
                    .toList()
                : const <String>[],
          );
        },
      ),
    ],
  );
}
