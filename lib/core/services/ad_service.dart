import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Google AdMob Service für Banner, Interstitial und Rewarded Ads.
///
/// Setup:
/// 1. AdMob Account + App erstellen
/// 2. AndroidManifest.xml: `<meta-data android:name="com.google.android.gms.ads.APPLICATION_ID" android:value="ca-app-pub-XXXX~YYYY"/>`
/// 3. iOS Info.plist: GADApplicationIdentifier = ca-app-pub-XXXX~YYYY
/// 4. In main.dart: await AdService.initialize();
class AdService {
  static bool _initialized = false;

  BannerAd? _bannerAd;
  RewardedAd? _rewardedAd;
  InterstitialAd? _interstitialAd;

  bool _isBannerLoaded = false;
  bool _isRewardedLoaded = false;
  bool _isInterstitialLoaded = false;

  // Callbacks
  VoidCallback? onBannerLoaded;
  VoidCallback? onRewardedLoaded;

  bool get isBannerLoaded => _isBannerLoaded;
  bool get isRewardedLoaded => _isRewardedLoaded;
  bool get isInterstitialLoaded => _isInterstitialLoaded;
  BannerAd? get bannerAd => _bannerAd;

  // Ad Unit IDs (überschreibbar)
  final String bannerAdUnitId;
  final String rewardedAdUnitId;
  final String interstitialAdUnitId;

  AdService({
    String? bannerAdUnitId,
    String? rewardedAdUnitId,
    String? interstitialAdUnitId,
  })  : bannerAdUnitId = bannerAdUnitId ?? _testBannerAdUnitId,
        rewardedAdUnitId = rewardedAdUnitId ?? _testRewardedAdUnitId,
        interstitialAdUnitId =
            interstitialAdUnitId ?? _testInterstitialAdUnitId;

  // === TEST AD UNIT IDS ===

  static String get _testBannerAdUnitId {
    if (Platform.isAndroid) return 'ca-app-pub-3940256099942544/6300978111';
    if (Platform.isIOS) return 'ca-app-pub-3940256099942544/2934735716';
    return '';
  }

  static String get _testRewardedAdUnitId {
    if (Platform.isAndroid) return 'ca-app-pub-3940256099942544/5224354917';
    if (Platform.isIOS) return 'ca-app-pub-3940256099942544/1712485313';
    return '';
  }

  static String get _testInterstitialAdUnitId {
    if (Platform.isAndroid) return 'ca-app-pub-3940256099942544/1033173712';
    if (Platform.isIOS) return 'ca-app-pub-3940256099942544/4411468910';
    return '';
  }

  // === INITIALIZATION ===

  static Future<void> initialize() async {
    if (_initialized) return;
    await MobileAds.instance.initialize();
    _initialized = true;
    debugPrint('[AdService] Initialized');
  }

  // === BANNER ADS ===

  void loadBannerAd({AdSize size = AdSize.banner}) {
    _bannerAd?.dispose();
    _isBannerLoaded = false;

    _bannerAd = BannerAd(
      adUnitId: bannerAdUnitId,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('[AdService] Banner loaded');
          _isBannerLoaded = true;
          onBannerLoaded?.call();
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('[AdService] Banner failed: ${error.message}');
          ad.dispose();
          _bannerAd = null;
          _isBannerLoaded = false;
        },
      ),
    )..load();
  }

  void disposeBanner() {
    _bannerAd?.dispose();
    _bannerAd = null;
    _isBannerLoaded = false;
  }

  // === REWARDED ADS ===

  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('[AdService] Rewarded loaded');
          _rewardedAd = ad;
          _isRewardedLoaded = true;
          onRewardedLoaded?.call();
        },
        onAdFailedToLoad: (error) {
          debugPrint('[AdService] Rewarded failed: ${error.message}');
          _rewardedAd = null;
          _isRewardedLoaded = false;
        },
      ),
    );
  }

  /// Zeigt Rewarded Ad. Gibt true zurück wenn Reward verdient wurde.
  Future<bool> showRewardedAd() async {
    if (_rewardedAd == null) {
      debugPrint('[AdService] Rewarded not loaded');
      return false;
    }

    bool rewarded = false;

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _rewardedAd = null;
        _isRewardedLoaded = false;
        loadRewardedAd(); // Preload next
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint('[AdService] Rewarded show failed: ${error.message}');
        ad.dispose();
        _rewardedAd = null;
        _isRewardedLoaded = false;
        loadRewardedAd();
      },
    );

    await _rewardedAd!.show(
      onUserEarnedReward: (ad, reward) {
        debugPrint('[AdService] Reward: ${reward.amount} ${reward.type}');
        rewarded = true;
      },
    );

    return rewarded;
  }

  // === INTERSTITIAL ADS ===

  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('[AdService] Interstitial loaded');
          _interstitialAd = ad;
          _isInterstitialLoaded = true;
        },
        onAdFailedToLoad: (error) {
          debugPrint('[AdService] Interstitial failed: ${error.message}');
          _interstitialAd = null;
          _isInterstitialLoaded = false;
        },
      ),
    );
  }

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
