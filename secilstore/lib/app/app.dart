import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/constants/app_colors.dart';
import 'router/app_router.dart';

class SecilStoreApp extends ConsumerWidget {
  const SecilStoreApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'SeçilStore',
      scaffoldMessengerKey: scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: AppColors.primary,
        scaffoldBackgroundColor: AppColors.surface,
        textTheme: GoogleFonts.poppinsTextTheme(),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.surface,
          elevation: 0.5,
          shadowColor: Colors.black.withValues(alpha: 0.1),
          scrolledUnderElevation: 0.5,
          surfaceTintColor: Colors.transparent,
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        splashFactory: InkSparkle.splashFactory,
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            splashFactory: InkSparkle.splashFactory,
          ),
        ),
      ),
      routerConfig: router,
    );
  }
}
