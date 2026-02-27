import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import '../constants/app_constants.dart';

class AnalyticsService {
  AnalyticsService._();

  static FirebaseAnalytics? get _analytics =>
      Firebase.apps.isEmpty ? null : FirebaseAnalytics.instance;

  static FirebaseAnalyticsObserver? get observer {
    if (Firebase.apps.isEmpty) return null;
    return FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);
  }

  static Future<void> logLogin() async {
    await _analytics?.logLogin(loginMethod: 'phone');
  }

  static Future<void> logViewWallet() async {
    await _analytics?.logEvent(
      name: 'view_wallet',
      parameters: {'brand_id': AppConstants.brandId},
    );
  }

  static Future<void> logSelectCampaign({
    required String campaignId,
    required bool isCombinable,
  }) async {
    await _analytics?.logEvent(
      name: 'select_campaign',
      parameters: {
        'campaign_id': campaignId,
        'is_combinable': isCombinable,
      },
    );
  }

  static Future<void> logGenerateQr({
    required int campaignCount,
    required double coinAmount,
  }) async {
    await _analytics?.logEvent(
      name: 'generate_qr',
      parameters: {
        'campaign_count': campaignCount,
        'coin_amount': coinAmount,
      },
    );
  }

  static Future<void> logQrRefresh({required String trigger}) async {
    await _analytics?.logEvent(
      name: 'qr_refresh',
      parameters: {'trigger': trigger},
    );
  }
}
