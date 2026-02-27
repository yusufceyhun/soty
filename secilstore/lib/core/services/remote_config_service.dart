import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  RemoteConfigService._();

  static bool _isInitialized = false;
  static final Map<String, Object> _fallbackDefaults = <String, Object>{
    'show_online_shopping': true,
    'qr_refresh_interval': 60,
    'max_campaign_selection': 10,
  };

  static Future<void> init() async {
    if (Firebase.apps.isEmpty) {
      return;
    }

    try {
      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setDefaults(_fallbackDefaults);
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 1),
      ));
      await remoteConfig.fetchAndActivate();
      _isInitialized = true;
    } catch (_) {
      // Use defaults if fetch fails
    }
  }

  static bool get showOnlineShopping {
    if (!_isInitialized || Firebase.apps.isEmpty) {
      return _fallbackDefaults['show_online_shopping'] as bool;
    }
    return FirebaseRemoteConfig.instance.getBool('show_online_shopping');
  }

  static int get qrRefreshInterval {
    if (!_isInitialized || Firebase.apps.isEmpty) {
      return _fallbackDefaults['qr_refresh_interval'] as int;
    }
    return FirebaseRemoteConfig.instance.getInt('qr_refresh_interval');
  }

  static int get maxCampaignSelection {
    if (!_isInitialized || Firebase.apps.isEmpty) {
      return _fallbackDefaults['max_campaign_selection'] as int;
    }
    return FirebaseRemoteConfig.instance.getInt('max_campaign_selection');
  }
}
