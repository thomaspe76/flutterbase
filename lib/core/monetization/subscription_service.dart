import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subscription_service.g.dart';

@Riverpod(keepAlive: true)
class SubscriptionService extends _$SubscriptionService {
  @override
  Future<bool> build() async {
    // Initialize RevenueCat here
    // await Purchases.configure(PurchasesConfiguration('YOUR_API_KEY'));
    // For now, we return false (not pro) by default until configured
    return false;
  }

  Future<void> init(String apiKey) async {
    try {
      await Purchases.configure(PurchasesConfiguration(apiKey));
      await checkSubscriptionStatus();
    } catch (e) {
      // Handle error
    }
  }

  Future<void> checkSubscriptionStatus() async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      // Replace 'pro' with your actual entitlement identifier
      final isPro = customerInfo.entitlements.all['pro']?.isActive ?? false;
      state = AsyncValue.data(isPro);
    } on PlatformException catch (_) {
      state = const AsyncValue.data(false);
    }
  }

  Future<void> restorePurchases() async {
    try {
      final customerInfo = await Purchases.restorePurchases();
      final isPro = customerInfo.entitlements.all['pro']?.isActive ?? false;
      state = AsyncValue.data(isPro);
    } on PlatformException catch (_) {}
  }
}
