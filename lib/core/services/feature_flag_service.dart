import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'hive_service.dart';

/// Subscription-Stufen
enum SubscriptionTier {
  free,
  pro,
  family,
  lifetime,
}

/// Verwaltet Feature-Zugriff basierend auf Subscription + Remote Config.
class FeatureFlagService {
  // Hive Keys
  static const String _tierKey = 'subscription_tier';
  static const String _adFreeUntilKey = 'ad_free_until';
  static const String _referralCountKey = 'completed_referrals';

  SubscriptionTier _currentTier = SubscriptionTier.free;
  DateTime? _adFreeUntil;
  int _completedReferrals = 0;

  FirebaseRemoteConfig? _remoteConfig;

  // === GETTERS ===

  SubscriptionTier get currentTier => _currentTier;
  int get completedReferrals => _completedReferrals;

  bool get isFree => _currentTier == SubscriptionTier.free;
  bool get isPremium => _currentTier != SubscriptionTier.free;
  bool get isLifetime => _currentTier == SubscriptionTier.lifetime;

  bool get isAdFree {
    if (isPremium) return true;
    if (_adFreeUntil != null && _adFreeUntil!.isAfter(DateTime.now())) {
      return true;
    }
    return false;
  }

  Duration? get adFreeTimeRemaining {
    if (_adFreeUntil == null) return null;
    final remaining = _adFreeUntil!.difference(DateTime.now());
    return remaining.isNegative ? null : remaining;
  }

  // === INITIALIZATION ===

  /// Lädt Status aus Hive + Remote Config
  Future<void> initialize() async {
    await _loadFromStorage();
    await _initRemoteConfig();
  }

  Future<void> _loadFromStorage() async {
    try {
      final tierIndex =
          HiveService.getSetting<int>(_tierKey, defaultValue: 0) ?? 0;
      _currentTier = SubscriptionTier
          .values[tierIndex.clamp(0, SubscriptionTier.values.length - 1)];

      final adFreeTimestamp = HiveService.getSetting<int>(_adFreeUntilKey);
      if (adFreeTimestamp != null) {
        _adFreeUntil = DateTime.fromMillisecondsSinceEpoch(adFreeTimestamp);
      }

      _completedReferrals =
          HiveService.getSetting<int>(_referralCountKey, defaultValue: 0) ?? 0;
    } catch (e) {
      debugPrint('[FeatureFlagService] Load failed: $e');
    }
  }

  Future<void> _initRemoteConfig() async {
    try {
      _remoteConfig = FirebaseRemoteConfig.instance;
      await _remoteConfig!.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1),
      ),);
      await _remoteConfig!.fetchAndActivate();
      debugPrint('[FeatureFlagService] Remote Config loaded');
    } catch (e) {
      debugPrint('[FeatureFlagService] Remote Config failed: $e');
    }
  }

  // === SUBSCRIPTION MANAGEMENT ===

  Future<void> setTier(SubscriptionTier tier) async {
    _currentTier = tier;
    await HiveService.setSetting(_tierKey, tier.index);
  }

  /// Gewährt temporäre Werbefreiheit (z.B. durch Rewarded Video)
  Future<void> grantAdFreeTime(
      {Duration duration = const Duration(hours: 24),}) async {
    _adFreeUntil = DateTime.now().add(duration);
    await HiveService.setSetting(
        _adFreeUntilKey, _adFreeUntil!.millisecondsSinceEpoch,);
  }

  /// Erhöht Referral-Zähler
  Future<void> incrementReferralCount() async {
    _completedReferrals++;
    await HiveService.setSetting(_referralCountKey, _completedReferrals);
  }

  // === FEATURE CHECKS ===

  /// Prüft ob User innerhalb eines Limits ist
  bool isWithinLimit(int currentCount, {required int freeLimit}) {
    if (isPremium) return true;
    return currentCount < freeLimit;
  }

  /// Holt Remote Config Wert (mit Fallback)
  String getRemoteString(String key, {String defaultValue = ''}) {
    return _remoteConfig?.getString(key) ?? defaultValue;
  }

  bool getRemoteBool(String key, {bool defaultValue = false}) {
    return _remoteConfig?.getBool(key) ?? defaultValue;
  }

  int getRemoteInt(String key, {int defaultValue = 0}) {
    return _remoteConfig?.getInt(key) ?? defaultValue;
  }

  /// Prüft ob ein Feature via Remote Config aktiviert ist
  bool isFeatureEnabled(String featureKey) {
    return getRemoteBool('feature_$featureKey', defaultValue: true);
  }
}

// === RIVERPOD PROVIDERS ===

final featureFlagServiceProvider = Provider<FeatureFlagService>((ref) {
  return FeatureFlagService();
});

final isPremiumProvider = Provider<bool>((ref) {
  return ref.watch(featureFlagServiceProvider).isPremium;
});

final isAdFreeProvider = Provider<bool>((ref) {
  return ref.watch(featureFlagServiceProvider).isAdFree;
});

final subscriptionTierProvider = Provider<SubscriptionTier>((ref) {
  return ref.watch(featureFlagServiceProvider).currentTier;
});
