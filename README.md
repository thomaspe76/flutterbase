# flutterbase

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Integrierte Services

### HiveService
Lokale Datenpersistenz mit Hive.
```dart
await HiveService.initialize();
HiveService.settings.put('key', 'value');
```

### FeatureFlagService
Verwaltet Free/Premium Feature-Zugriff.
```dart
final service = ref.read(featureFlagServiceProvider);
if (service.isPremium) { /* Premium Feature */ }
service.grantAdFreeTime(); // 24h werbefrei
```

### AdService
Google AdMob Integration.
```dart
final adService = AdService();
adService.loadBannerAd(onLoaded: () => setState(() {}));
adService.loadRewardedAd();
final rewarded = await adService.showRewardedAd();
```

### ReferralService
Play Store Install Referrer für Empfehlungsprogramme.
```dart
final service = ReferralService(maxRewards: 3, rewardDays: 7);
await service.shareReferralLink(userId: 'user123', shareText: 'Check out this app: {link}');
final referrerId = await service.checkAndProcessInstallReferrer(currentUserId);
```

## Farbschemata

Vordefinierte Paletten in `AppColorSchemes`:
- `finance` - Emerald/Grün (Geld, Wachstum)
- `productivity` - Blue (Vertrauen, Fokus)
- `health` - Teal (Wellness, Balance)
- `utility` - Slate (Neutral, Tool-artig)

## 🔧 Dependency Injection
