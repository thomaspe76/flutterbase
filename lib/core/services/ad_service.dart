import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Service für Google AdMob Integration (Banner + Rewarded Video).
///
/// Setup:
/// 1. AdMob Account erstellen und App registrieren
/// 2. Ad Unit IDs in .env eintragen
/// 3. AndroidManifest.xml: `<meta-data android:name="com.google.android.gms.ads.APPLICATION_ID" android:value="ca-app-pub-XXXX"/>`
/// 4. iOS Info.plist: GADApplicationIdentifier
class AdService {
  static bool _initialized = false;

  BannerAd? _bannerAd;
  RewardedAd? _rewardedAd;
  InterstitialAd? _interstitialAd;

  bool _isBannerLoaded = false;
  bool _isRewardedLoaded = false;
  bool _isInterstitialLoaded = false;

  bool get isBannerAdLoaded => _isBannerLoaded;
  bool get isRewardedAdLoaded => _isRewardedLoaded;
  bool get isInterstitialAdLoaded => _isInterstitialLoaded;
  BannerAd? get bannerAd => _bannerAd;

  /// Test Ad Unit IDs - für Produktion durch echte IDs ersetzen!
  final String _bannerAdUnitId;
  final String _rewardedAdUnitId;
  final String _interstitialAdUnitId;

  AdService({
    String? bannerAdUnitId,
    String? rewardedAdUnitId,
    String? interstitialAdUnitId,
  })  : _bannerAdUnitId = bannerAdUnitId ?? _defaultBannerAdUnitId,
        _rewardedAdUnitId = rewardedAdUnitId ?? _defaultRewardedAdUnitId,
        _interstitialAdUnitId =
            interstitialAdUnitId ?? _defaultInterstitialAdUnitId;

  // Test Ad Unit IDs (funktionieren in Debug-Builds)
  static String get _defaultBannerAdUnitId {
    if (Platform.isAndroid) return 'ca-app-pub-3940256099942544/6300978111';
    if (Platform.isIOS) return 'ca-app-pub-3940256099942544/2934735716';
    throw UnsupportedError('Unsupported platform');
  }

  static String get _defaultRewardedAdUnitId {
    if (Platform.isAndroid) return 'ca-app-pub-3940256099942544/5224354917';
    if (Platform.isIOS) return 'ca-app-pub-3940256099942544/1712485313';
    throw UnsupportedError('Unsupported platform');
  }

  static String get _defaultInterstitialAdUnitId {
    if (Platform.isAndroid) return 'ca-app-pub-3940256099942544/1033173712';
    if (Platform.isIOS) return 'ca-app-pub-3940256099942544/4411468910';
    throw UnsupportedError('Unsupported platform');
  }

  /// Initializes the Google Mobile Ads SDK.
  ///
  /// This must be called before loading any ads.
  /// Returns a `Future<void>` that completes when initialization is done.
  static Future<void> initialize() async {
    if (_initialized) return;
    await MobileAds.instance.initialize();
    _initialized = true;
    debugPrint('[AdService] Initialized');
  }

  // === BANNER ADS ===

  /// Lädt einen Banner-Ad
  void loadBannerAd({
    AdSize size = AdSize.banner,
    Function()? onLoaded,
    Function(String error)? onFailed,
  }) {
    _bannerAd?.dispose();
    _isBannerLoaded = false;

    _bannerAd = BannerAd(
      adUnitId: _bannerAdUnitId,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('[AdService] Banner loaded');
          _isBannerLoaded = true;
          onLoaded?.call();
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('[AdService] Banner failed: ${error.message}');
          ad.dispose();
          _bannerAd = null;
          _isBannerLoaded = false;
          onFailed?.call(error.message);
        },
        onAdClicked: (ad) => debugPrint('[AdService] Banner clicked'),
      ),
    )..load();
  }

  /// Entfernt den Banner
  void disposeBannerAd() {
    _bannerAd?.dispose();
    _bannerAd = null;
    _isBannerLoaded = false;
  }

  // === REWARDED ADS ===

  /// Lädt einen Rewarded Video Ad (im Voraus laden!)
  void loadRewardedAd({Function()? onLoaded}) {
    RewardedAd.load(
      adUnitId: _rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('[AdService] Rewarded ad loaded');
          _rewardedAd = ad;
          _isRewardedLoaded = true;
          onLoaded?.call();
        },
        onAdFailedToLoad: (error) {
          debugPrint('[AdService] Rewarded ad failed: ${error.message}');
          _rewardedAd = null;
          _isRewardedLoaded = false;
        },
      ),
    );
  }

  /// Zeigt Rewarded Video und gibt zurück ob Reward verdient wurde
  Future<bool> showRewardedAd(
      {Function(int amount, String type)? onRewarded}) async {
    if (_rewardedAd == null) {
      debugPrint('[AdService] Rewarded ad not loaded');
      return false;
    }

    bool rewarded = false;

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        debugPrint('[AdService] Rewarded ad dismissed');
        ad.dispose();
        _rewardedAd = null;
        _isRewardedLoaded = false;
        loadRewardedAd(); // Nächsten vorladen
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint('[AdService] Rewarded ad show failed: ${error.message}');
        ad.dispose();
        _rewardedAd = null;
        _isRewardedLoaded = false;
        loadRewardedAd();
      },
    );

    await _rewardedAd!.show(
      onUserEarnedReward: (ad, reward) {
        debugPrint(
            '[AdService] Reward earned: ${reward.amount} ${reward.type}');
        rewarded = true;
        onRewarded?.call(reward.amount.toInt(), reward.type);
      },
    );

    return rewarded;
  }

  // === INTERSTITIAL ADS ===

  /// Lädt einen Interstitial Ad
  void loadInterstitialAd({Function()? onLoaded}) {
    InterstitialAd.load(
      adUnitId: _interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('[AdService] Interstitial loaded');
          _interstitialAd = ad;
          _isInterstitialLoaded = true;
          onLoaded?.call();
        },
        onAdFailedToLoad: (error) {
          debugPrint('[AdService] Interstitial failed: ${error.message}');
          _interstitialAd = null;
          _isInterstitialLoaded = false;
        },
      ),
    );
  }

  /// Zeigt Interstitial Ad
  Future<void> showInterstitialAd() async {
    if (_interstitialAd == null) return;

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _interstitialAd = null;
        _isInterstitialLoaded = false;
        loadInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _interstitialAd = null;
        _isInterstitialLoaded = false;
      },
    );

    await _interstitialAd!.show();
  }

  // === CLEANUP ===

  void dispose() {
    _bannerAd?.dispose();
    _rewardedAd?.dispose();
    _interstitialAd?.dispose();
  }
}
