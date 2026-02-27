import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/app.dart';
import 'core/services/remote_config_service.dart';

const _enableFirebase =
    bool.fromEnvironment('ENABLE_FIREBASE', defaultValue: false);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('tr_TR');

  if (_enableFirebase) {
    try {
      await Firebase.initializeApp();

      // Crashlytics
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };

      // Remote Config
      await RemoteConfigService.init();
    } catch (e) {
      // Firebase not configured — continue without it
      if (kDebugMode) {
        debugPrint('Firebase init skipped: $e');
      }
    }
  }

  runApp(
    const ProviderScope(
      child: SecilStoreApp(),
    ),
  );
}
