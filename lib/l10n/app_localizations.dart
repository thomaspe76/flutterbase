import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Flutter Boilerplate'**
  String get appTitle;

  /// No description provided for @dashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboardTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @enableNotifications.
  ///
  /// In en, this message translates to:
  /// **'Enable Notifications'**
  String get enableNotifications;

  /// No description provided for @securityBackup.
  ///
  /// In en, this message translates to:
  /// **'Security & Backup'**
  String get securityBackup;

  /// No description provided for @cloudBackup.
  ///
  /// In en, this message translates to:
  /// **'Cloud Backup'**
  String get cloudBackup;

  /// No description provided for @haptics.
  ///
  /// In en, this message translates to:
  /// **'Haptics'**
  String get haptics;

  /// No description provided for @legal.
  ///
  /// In en, this message translates to:
  /// **'Legal'**
  String get legal;

  /// No description provided for @imprint.
  ///
  /// In en, this message translates to:
  /// **'Imprint'**
  String get imprint;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @licenses.
  ///
  /// In en, this message translates to:
  /// **'Licenses'**
  String get licenses;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @dashboardUIShowcase.
  ///
  /// In en, this message translates to:
  /// **'UI Showcase'**
  String get dashboardUIShowcase;

  /// No description provided for @dashboardRecentActivity.
  ///
  /// In en, this message translates to:
  /// **'Recent Activity'**
  String get dashboardRecentActivity;

  /// No description provided for @activitySystemUpdate.
  ///
  /// In en, this message translates to:
  /// **'System Update'**
  String get activitySystemUpdate;

  /// No description provided for @activitySystemUpdateDesc.
  ///
  /// In en, this message translates to:
  /// **'Successfully updated to v1.0.0'**
  String get activitySystemUpdateDesc;

  /// No description provided for @activitySecurityCheck.
  ///
  /// In en, this message translates to:
  /// **'Security Check'**
  String get activitySecurityCheck;

  /// No description provided for @activitySecurityCheckDesc.
  ///
  /// In en, this message translates to:
  /// **'All systems operational'**
  String get activitySecurityCheckDesc;

  /// No description provided for @activityBackupCompleted.
  ///
  /// In en, this message translates to:
  /// **'Backup Completed'**
  String get activityBackupCompleted;

  /// No description provided for @activityBackupCompletedDesc.
  ///
  /// In en, this message translates to:
  /// **'Cloud sync finished at 10:00 AM'**
  String get activityBackupCompletedDesc;

  /// No description provided for @welcomeAppTitle.
  ///
  /// In en, this message translates to:
  /// **'Flutterbase App'**
  String get welcomeAppTitle;

  /// No description provided for @welcomeVersion.
  ///
  /// In en, this message translates to:
  /// **'v1.0.0'**
  String get welcomeVersion;

  /// No description provided for @welcomePro.
  ///
  /// In en, this message translates to:
  /// **'Pro'**
  String get welcomePro;

  /// No description provided for @welcomeSyncNow.
  ///
  /// In en, this message translates to:
  /// **'Sync Now'**
  String get welcomeSyncNow;

  /// No description provided for @welcomeSynced.
  ///
  /// In en, this message translates to:
  /// **'Synced'**
  String get welcomeSynced;

  /// No description provided for @welcomeSystemStatus.
  ///
  /// In en, this message translates to:
  /// **'System Status'**
  String get welcomeSystemStatus;

  /// No description provided for @welcomeDetails.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get welcomeDetails;

  /// No description provided for @welcomeDemoDescription.
  ///
  /// In en, this message translates to:
  /// **'This is a demonstration of the Hero animation and shared element transitions. You can put detailed system status or feature information here.'**
  String get welcomeDemoDescription;

  /// No description provided for @sliderTitle.
  ///
  /// In en, this message translates to:
  /// **'Interactive Input'**
  String get sliderTitle;

  /// No description provided for @sliderLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get sliderLow;

  /// No description provided for @sliderMed.
  ///
  /// In en, this message translates to:
  /// **'Med'**
  String get sliderMed;

  /// No description provided for @sliderHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get sliderHigh;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
