# Technical Documentation & Developer Guide

## 1. Project Overview
This project is a production-ready Flutter application built with a focus on scalability, maintainability, and modern best practices. It uses a feature-first architecture and relies on robust libraries for state management, navigation, and backend integration.

**Key Technologies:**
- **Framework**: Flutter (Dart)
- **State Management**: [Riverpod](https://riverpod.dev/) (with `riverpod_annotation` & `freezed`)
- **Navigation**: [GoRouter](https://pub.dev/packages/go_router)
- **Backend**: [Supabase](https://supabase.com/) (Auth, Database, Realtime)
- **Localization**: `flutter_localizations` (ARB files)

---

## 2. Architecture & Folder Structure
The project follows a **Feature-First** architecture. Code is organized by what it *does* (features) rather than what it *is* (layers).

```
lib/
├── core/                 # Core functionality shared across the app
│   ├── config/           # Environment config (EnvConfig)
│   ├── network/          # Network clients (Dio, Supabase)
│   ├── theme/            # App theme, colors, typography
│   ├── security/         # Biometrics, Secure Storage, Privacy
│   ├── ai/               # AI Service integration (Gemini)
│   └── monetization/     # Ads & Subscriptions logic
├── features/             # Feature modules
│   ├── auth/             # Authentication (Login, Signup, Repo)
│   ├── dashboard/        # Main dashboard UI & logic
│   ├── settings/         # Settings screen & logic
│   └── onboarding/       # Onboarding flow
├── shared/               # Shared UI components & widgets
│   ├── widgets/          # Reusable widgets (Buttons, Inputs)
│   └── extensions/       # Dart extensions
└── l10n/                 # Localization files (.arb)
```

### Feature Structure
Each feature folder typically contains:
- `data/`: Repositories, Data Sources, DTOs.
- `logic/`: State management (Providers, Notifiers).
- `presentation/`: Widgets, Screens.

---

## 3. Configuration & Environment
Configuration is managed via the `EnvConfig` class in `lib/core/config/env_config.dart`.

**Entry Points:**
- `lib/main.dart`: Default entry point.
- `lib/main_dev.dart`: Development entry point (uses dev config).
- `lib/main_prod.dart`: Production entry point (uses prod config).

**Action Required:**
Update `EnvConfig` with your actual API keys and secrets. **Do not commit real secrets to public repositories.**

---

## 4. External Services Integration

### 4.1 Supabase (Backend & Auth)
- **File**: `lib/core/network/supabase_provider.dart`
- **Config**: Set `supabaseUrl` and `supabaseAnonKey` in `EnvConfig`.
- **Auth**: Logic is in `lib/features/auth/data/auth_repository.dart`.
- **Setup**:
    1. Create a Supabase project.
    2. Enable Email/Password authentication.
    3. Copy Project URL and Anon Key to `EnvConfig`.

### 4.2 RevenueCat (Subscriptions)
- **File**: `lib/core/monetization/subscription_service.dart`
- **Config**: Replace `'YOUR_API_KEY'` in `SubscriptionService.init()`.
- **Setup**:
    1. Create RevenueCat project.
    2. Define Entitlements (e.g., 'pro').
    3. Create Offerings and Packages.
    4. Link Google Play / App Store credentials.

### 4.3 AdMob (Ads)
- **File**: `lib/core/monetization/ad_service.dart`
- **Config**:
    - **Android**: Update `android/app/src/main/AndroidManifest.xml` with your App ID.
    - **iOS**: Update `ios/Runner/Info.plist` with your App ID.
    - **Dart**: Update Unit IDs in `AdService` or `AdBannerWidget`.
- **Setup**: Create AdMob account, get App ID, create Banner/Interstitial Ad Units.

### 4.4 Gemini AI (Generative AI)
- **File**: `lib/core/ai/ai_service.dart`
- **Config**: Set `geminiApiKey` in `EnvConfig`.
- **Usage**: `ref.read(aiServiceProvider).generateContent(...)`

### 4.5 Sentry (Crash Reporting)
- **File**: `lib/main.dart` (Initialization)
- **Config**: Set `sentryDsn` in `EnvConfig`.

---

## 5. Development Workflow

### Code Generation
This project uses `build_runner` for Riverpod, Freezed, and JSON serialization.
**Run this command after modifying any file with `@Riverpod`, `@freezed`, or `@JsonSerializable`:**
```bash
dart run build_runner build --delete-conflicting-outputs
```
*Tip: Use `watch` instead of `build` for auto-regeneration during development.*

### Localization
1. Edit `lib/l10n/app_en.arb` (English) and `app_de.arb` (German).
2. Run `flutter gen-l10n` (or simply build the app) to regenerate delegates.
3. Access strings via `AppLocalizations.of(context)!.keyName`.

### Theming
- Modify `lib/core/theme/app_theme.dart` to change global styles.
- Use `lib/core/theme/semantic_colors.dart` for custom semantic color extensions.

---

## 6. Troubleshooting & Common Issues

### "Undefined class ...Ref"
If you see errors like `Undefined class 'MyProviderRef'`, it means `riverpod_generator` hasn't run or there's a type mismatch.
**Fix**:
1. Run `dart run build_runner build --delete-conflicting-outputs`.
2. If the specific type (e.g., `MyProviderRef`) is still not found, change the function signature to use the generic `Ref`:
   ```dart
   // Before (might fail)
   MyState myProvider(MyProviderRef ref) { ... }

   // After (Fix)
   MyState myProvider(Ref ref) { ... }
   ```

### "EncryptedSharedPreferences" Deprecation
We use `resetOnError: true` instead of the deprecated `encryptedSharedPreferences: true` for Android in `SecureStorageProvider`.

### Biometric Auth Errors
Ensure `NSFaceIDUsageDescription` is set in `Info.plist` for iOS and `USE_BIOMETRIC` permission is in `AndroidManifest.xml` for Android.

---

## 7. Deployment Checklist
1. [ ] Update `pubspec.yaml` version.
2. [ ] Run `flutter test`.
3. [ ] Check `EnvConfig` for production keys.
4. [ ] Build Android: `flutter build appbundle`.
5. [ ] Build iOS: `flutter build ipa`.
