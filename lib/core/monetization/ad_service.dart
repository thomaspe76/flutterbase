import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'subscription_service.dart';

part 'ad_service.g.dart';

@Riverpod(keepAlive: true)
class AdService extends _$AdService {
  @override
  Future<void> build() async {
    // Initialize Mobile Ads SDK
    await MobileAds.instance.initialize();
  }

  // Helper to get banner ad unit ID based on platform
  String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111'; // Test ID
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716'; // Test ID
    }
    throw UnsupportedError('Unsupported platform');
  }
}

@riverpod
bool shouldShowAds(Ref ref) {
  final isPro = ref.watch(subscriptionServiceProvider).asData?.value ?? false;
  return !isPro;
}
