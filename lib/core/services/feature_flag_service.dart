import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'hive_service.dart';

/// Subscription-Stufen für die App
enum SubscriptionTier {
  free,
  pro,
  family,
  lifetime,
}

/// Verwaltet Feature-Zugriff basierend auf Subscription-Status.
///
/// Verwendung:
/// - Feature prüfen: featureFlagService.canAccess(FeatureFlag.customThemes)
/// - Tier ändern: featureFlagService.setTier(SubscriptionTier.pro)
/// - Ad-Free durch Video: featureFlagService.grantAdFreeTime()
class FeatureFlagService {
  static const String _tierKey = 'subscription_tier';
  static const String _adFreeUntilKey = 'ad_free_until';
  static const String _referralCountKey = 'referral_count';

  SubscriptionTier _currentTier = SubscriptionTier.free;
  DateTime? _adFreeUntil;
  int _completedReferrals = 0;

  SubscriptionTier get currentTier => _currentTier;
  int get completedReferrals => _completedReferrals;

  bool get isPremium => _currentTier != SubscriptionTier.free;
  bool get isLifetime => _currentTier == SubscriptionTier.lifetime;

  bool get isAdFree {
    if (isPremium) return true;
    if (_adFreeUntil != null && _adFreeUntil!.isAfter(DateTime.now())) {
      return true;
    }
    return false;
  }

  /// Lädt gespeicherten Status aus Hive
  Future<void> loadFromStorage() async {
    final settings = HiveService.settings;

    final tierIndex = settings.get(_tierKey, defaultValue: 0) as int;
    _currentTier = SubscriptionTier.values[tierIndex];

    final adFreeTimestamp = settings.get(_adFreeUntilKey) as int?;
    if (adFreeTimestamp != null) {
      _adFreeUntil = DateTime.fromMillisecondsSinceEpoch(adFreeTimestamp);
    }

    _completedReferrals =
        settings.get(_referralCountKey, defaultValue: 0) as int;
  }

  /// Setzt die Subscription-Stufe
  Future<void> setTier(SubscriptionTier tier) async {
    _currentTier = tier;
    await HiveService.settings.put(_tierKey, tier.index);
  }

  /// Gewährt temporäre Werbefreiheit (z.B. durch Rewarded Video)
  Future<void> grantAdFreeTime(
      {Duration duration = const Duration(hours: 24)}) async {
    _adFreeUntil = DateTime.now().add(duration);
    await HiveService.settings
        .put(_adFreeUntilKey, _adFreeUntil!.millisecondsSinceEpoch);
  }

  /// Erhöht Referral-Zähler
  Future<void> incrementReferralCount() async {
    _completedReferrals++;
    await HiveService.settings.put(_referralCountKey, _completedReferrals);
  }

  /// Prüft ob ein bestimmtes Feature verfügbar ist
  /// Überschreibe diese Methode in deiner App für spezifische Feature-Logik
  bool canAccessFeature(String featureKey) {
    // Standard: Alle Features für Premium verfügbar
    return isPremium;
  }

  /// Prüft ob ein Limit erreicht ist (z.B. 5 Voice-Inputs pro Tag)
  bool isWithinLimit(String limitKey, int currentCount, {int freeLimit = 5}) {
    if (isPremium) return true;
    return currentCount < freeLimit;
  }

  /// Zeit bis Werbefreiheit abläuft
  Duration? get adFreeTimeRemaining {
    if (_adFreeUntil == null) return null;
    final remaining = _adFreeUntil!.difference(DateTime.now());
    return remaining.isNegative ? null : remaining;
  }
}

// === Riverpod Providers ===

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
