# Flutterbase Boilerplate - AI Developer Guide 🤖

Diese Dokumentation dient als Leitfaden für KI-Agenten und Entwickler, die auf dieser Codebasis aufbauen. Sie erklärt die Architektur, die verfügbaren Services und spezifische Implementierungsregeln.

## 1. Tech Stack & Architektur 🛠️

*   **Framework:** Flutter (Latest Stable)
*   **Sprache:** Dart 3.x
*   **State Management:** [Riverpod](https://riverpod.dev/) (Annotation Syntax bevorzugt)
*   **Navigation:** [GoRouter](https://pub.dev/packages/go_router)
*   **Backend:** Firebase (Auth, Firestore, Crashlytics, Remote Config, Analytics, Dynamic Links, Storage)
*   **Local Storage:** Hive (⚠️ Besonderheit beachten!)
*   **Monetarisierung:** RevenueCat (IAP) + Google Mobile Ads (AdMob)
*   **Growth:** Android Install Referrer + Firebase Dynamic Links
*   **Charts:** fl_chart (für Datenvisualisierung)
*   **Audio:** record (für Voice-Features)

## 2. Kritische Regeln & Constraints ⚠️

### 🛑 Hive & Code Generation
**WICHTIG:** Wir nutzen `freezed` in Version 3.x. Dies führt zu Konflikten mit `hive_generator`.
*   **Regel:** `hive_generator` ist **NICHT** installiert.
*   **Action:** Du musst alle `TypeAdapter` für Hive **manuell schreiben**.
*   **Beispiel:** Siehe `lib/core/services/hive_service.dart` für ein Template eines manuellen Adapters.

### 🛑 Environment Variables
*   API-Keys und Secrets dürfen **niemals** hardcoded werden.
*   Nutze `flutter_dotenv` und die `.env` Datei.
*   **Template:** Kopiere `.env.example` zu `.env` und fülle die Werte aus.
*   **Verfügbare Keys:** Siehe `.env.example` für vollständige Liste (AdMob, RevenueCat, Dynamic Links, Gemini AI, Supabase).
*   Zugriff: `dotenv.env['KEY_NAME']`.

## 3. Core Services (Deep Dive) 🧠

Diese Services sind bereits implementiert und sollten wiederverwendet werden.

### `HiveService` (`lib/core/services/hive_service.dart`)
Zentraler Wrapper für lokalen Speicher.
*   **Initialisierung:** Erfolgt automatisch in `main.dart`.
*   **Nutzung:**
    ```dart
    // Box öffnen (falls noch nicht offen)
    final box = await HiveService.openBox<MyModel>('my_box');
    
    // Shortcuts für Standard-Boxen
    HiveService.settings.put('key', 'value');
    HiveService.cache.put('api_data', json);
    ```
*   **Adapter Registrierung:** `HiveService.registerAdapter(MyAdapter());`

### `FeatureFlagService` (`lib/core/services/feature_flag_service.dart`)
Die "Source of Truth" für Zugriffskontrolle (Free vs. Premium).
*   **Funktionsweise:** Kombiniert lokalen Status (Hive) mit Server-Config (Firebase Remote Config).
*   **Provider:**
    *   `isPremiumProvider`: Bool, true wenn User bezahlt hat.
    *   `isAdFreeProvider`: Bool, true wenn Premium ODER temporär werbefrei (z.B. nach Rewarded Ad).
*   **Nutzung im UI:**
    ```dart
    final isPremium = ref.watch(isPremiumProvider);
    if (!isPremium) showPaywall();
    ```

### `AdService` (`lib/core/services/ad_service.dart`)
Vorkonfigurierter Service für AdMob.
*   **Features:** Banner, Interstitial, Rewarded Ads.
*   **Setup:** IDs werden im Constructor oder via `.env` übergeben.
*   **Nutzung:**
    ```dart
    // Banner laden
    adService.loadBannerAd(onLoaded: () => setState(() {}));
    
    // Rewarded Video zeigen
    final rewardEarned = await adService.showRewardedAd();
    if (rewardEarned) featureFlagService.grantAdFreeTime();
    ```

### `ReferralService` (`lib/core/services/referral_service.dart`)
Wachstums-Engine für "Invite Friends" Features.
*   **Android:** Nutzt die native Play Store Install Referrer API (sehr zuverlässig). Erkennt, über welchen Link die App installiert wurde.
*   **iOS:** Nutzt Firebase Dynamic Links (da kein nativer Install Referrer).
*   **Logik:** Speichert Referrals in Firestore und prüft Limits (z.B. max 3 Belohnungen).

## 4. Design System & Styleguide 🎨

Wir nutzen ein striktes Design-Framework basierend auf Material 3 und Tailwind-ähnlichen Farbpaletten.

### 📜 Styleguide Regeln
1.  **Keine Hardcoded Colors:** Nutze niemals `Colors.blue` oder Hex-Codes im UI-Code.
2.  **Theme-First:** Nutze `Theme.of(context)` für TextStyles und Farben.
3.  **Spacing:** Nutze 4er-Grid (4, 8, 12, 16, 24, 32...).

### 🛠️ Core Components

#### `AppColorSchemes` (`lib/core/design_system/app_color_schemes.dart`)
Definiert unsere semantischen Paletten. Wähle die Palette passend zur App-Nische:
*   💰 **Finance:** `AppColorSchemes.finance` (Emerald)
*   🚀 **Productivity:** `AppColorSchemes.productivity` (Blue)
*   ❤️ **Health:** `AppColorSchemes.health` (Teal)
*   🛠️ **Utility:** `AppColorSchemes.utility` (Slate)

#### `AppTheme` (`lib/core/design_system/app_theme.dart`)
Zentrale Theme-Definition für Light & Dark Mode.
*   **Typography:** Google Fonts "Inter"
*   **Shapes:** Rounded Corners (12px - 16px)
*   **Inputs:** Filled Style mit Border
*   **Cards:** Flat Style mit Border (kein Shadow)

### 🧩 Nutzung im Code
```dart
// ✅ Richtig:
Container(
  color: AppColorSchemes.finance.primarySurface,
  child: Text(
    'Budget',
    style: Theme.of(context).textTheme.titleLarge,
  ),
)

// ❌ Falsch:
Container(
  color: Color(0xFF10B981),
  child: Text(
    'Budget',
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  ),
)
```

### `ToastService` (`lib/core/ui/toast_service.dart`)
Einheitliches Toast/Notification-System für User-Feedback.
*   **Design:** Moderne, abgerundete Floating-Snackbars (kein Overlay über Navigation).
*   **Typen:** Success (grün), Error (rot), Warning (gelb), Info (blau).
*   **Nutzung:**
    ```dart
    // Success Toast
    ToastService.success(context, 'Event erfolgreich erstellt!');
    
    // Error Toast
    ToastService.error(context, 'Fehler beim Speichern');
    
    // Mit Action
    ToastService.show(
      context,
      message: 'Element gelöscht',
      type: ToastType.info,
      actionLabel: 'RÜCKGÄNGIG',
      onAction: () => restore(),
    );
    ```

## 5. Workflow für neue Features 🚀

Wenn du ein neues Feature implementierst, folge diesem Ablauf:

1.  **Check:** Ist es ein Premium-Feature? -> Nutze `FeatureFlagService`.
2.  **Daten:**
    *   Nur lokal? -> Nutze `HiveService` (Schreibe Adapter manuell!).
    *   Sync benötigt? -> Nutze `Firestore`.
3.  **State:** Erstelle einen Riverpod Provider (nutze `@riverpod` Annotationen wo möglich, außer es gibt Konflikte).
4.  **UI:** Baue Widgets basierend auf `AppTheme`.

## 6. Deployment Checkliste ✅

Bevor du "fertig" meldest, prüfe:
1.  [ ] `.env` Datei existiert und enthält valide Keys (kopiert von `.env.example` und ausgefüllt).
2.  [ ] `flutter pub run build_runner build --delete-conflicting-outputs` lief erfolgreich.
3.  [ ] Keine Lint-Errors im Code (`flutter analyze`).
4.  [ ] `AndroidManifest.xml` und `Info.plist` enthalten die korrekten AdMob App-IDs.
5.  [ ] Firebase ist konfiguriert (`flutterfire configure`).

## 7. Verfügbare Packages 📦

### Production Dependencies
- **State & DI:** `flutter_riverpod`, `get_it`, `injectable`
- **Firebase:** `firebase_core`, `firebase_auth`, `cloud_firestore`, `firebase_analytics`, `firebase_crashlytics`, `firebase_remote_config`, `firebase_dynamic_links`, `firebase_storage`
- **Network:** `dio`, `retrofit`, `connectivity_plus`
- **Storage:** `hive`, `hive_flutter`, `path_provider`, `flutter_secure_storage`, `shared_preferences`
- **Monetization:** `purchases_flutter`, `google_mobile_ads`
- **Referral:** `android_play_install_referrer`, `share_plus`
- **Utils:** `freezed_annotation`, `json_annotation`, `equatable`, `fpdart`, `intl`, `logger`, `uuid`, `package_info_plus`, `permission_handler`, `url_launcher`
- **Audio:** `record` (für Voice-Recording)
- **Charts:** `fl_chart` (für Datenvisualisierung)
- **UI:** `flutter_dotenv`, `cached_network_image`, `shimmer`, `flutter_animate`, `google_fonts`
- **AI:** `google_generative_ai`
- **Other:** `supabase_flutter`, `in_app_review`, `local_auth`, `flutter_local_notifications`, `accessibility_tools`

### Dev Dependencies
- **Code Gen:** `build_runner`, `freezed`, `json_serializable`, `riverpod_generator`, `injectable_generator`, `retrofit_generator`
- **Linting:** `flutter_lints`
