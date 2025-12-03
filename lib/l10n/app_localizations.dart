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

  /// Der Titel der Anwendung
  ///
  /// In de, this message translates to:
  /// **'FlutterBase'**
  String get appTitle;

  /// Willkommensnachricht
  ///
  /// In de, this message translates to:
  /// **'Willkommen'**
  String get welcome;

  /// Detaillierte Willkommensnachricht
  ///
  /// In de, this message translates to:
  /// **'Willkommen bei FlutterBase - Eine professionell strukturierte Flutter App'**
  String get welcomeMessage;

  /// Startseite Label
  ///
  /// In de, this message translates to:
  /// **'Startseite'**
  String get home;

  /// Einstellungen Label
  ///
  /// In de, this message translates to:
  /// **'Einstellungen'**
  String get settings;

  /// Profil Label
  ///
  /// In de, this message translates to:
  /// **'Profil'**
  String get profile;

  /// Anmelden Button
  ///
  /// In de, this message translates to:
  /// **'Anmelden'**
  String get signIn;

  /// Registrieren Button
  ///
  /// In de, this message translates to:
  /// **'Registrieren'**
  String get signUp;

  /// Abmelden Button
  ///
  /// In de, this message translates to:
  /// **'Abmelden'**
  String get signOut;

  /// E-Mail Feld
  ///
  /// In de, this message translates to:
  /// **'E-Mail'**
  String get email;

  /// Passwort Feld
  ///
  /// In de, this message translates to:
  /// **'Passwort'**
  String get password;

  /// Passwort bestätigen Feld
  ///
  /// In de, this message translates to:
  /// **'Passwort bestätigen'**
  String get confirmPassword;

  /// Passwort vergessen Link
  ///
  /// In de, this message translates to:
  /// **'Passwort vergessen?'**
  String get forgotPassword;

  /// Speichern Button
  ///
  /// In de, this message translates to:
  /// **'Speichern'**
  String get save;

  /// Abbrechen Button
  ///
  /// In de, this message translates to:
  /// **'Abbrechen'**
  String get cancel;

  /// Löschen Button
  ///
  /// In de, this message translates to:
  /// **'Löschen'**
  String get delete;

  /// Bearbeiten Button
  ///
  /// In de, this message translates to:
  /// **'Bearbeiten'**
  String get edit;

  /// Suchen Label
  ///
  /// In de, this message translates to:
  /// **'Suchen'**
  String get search;

  /// Ladeindikator Text
  ///
  /// In de, this message translates to:
  /// **'Lädt...'**
  String get loading;

  /// Fehler Label
  ///
  /// In de, this message translates to:
  /// **'Fehler'**
  String get error;

  /// Erfolg Label
  ///
  /// In de, this message translates to:
  /// **'Erfolgreich'**
  String get success;

  /// Erneut versuchen Button
  ///
  /// In de, this message translates to:
  /// **'Erneut versuchen'**
  String get retry;

  /// Keine Daten Nachricht
  ///
  /// In de, this message translates to:
  /// **'Keine Daten verfügbar'**
  String get noDataAvailable;

  /// Generische Fehlermeldung
  ///
  /// In de, this message translates to:
  /// **'Etwas ist schiefgelaufen'**
  String get somethingWentWrong;

  /// E-Mail Validierungsfehler
  ///
  /// In de, this message translates to:
  /// **'E-Mail ist erforderlich'**
  String get emailRequired;

  /// E-Mail Format Fehler
  ///
  /// In de, this message translates to:
  /// **'Ungültige E-Mail-Adresse'**
  String get emailInvalid;

  /// Passwort Validierungsfehler
  ///
  /// In de, this message translates to:
  /// **'Passwort ist erforderlich'**
  String get passwordRequired;

  /// Passwort Länge Fehler
  ///
  /// In de, this message translates to:
  /// **'Passwort muss mindestens {minLength} Zeichen lang sein'**
  String passwordTooShort(int minLength);

  /// Passwort Übereinstimmung Fehler
  ///
  /// In de, this message translates to:
  /// **'Passwörter stimmen nicht überein'**
  String get passwordsDoNotMatch;

  /// Anzahl der Einträge
  ///
  /// In de, this message translates to:
  /// **'{count, plural, =0{Keine Einträge} =1{1 Eintrag} other{{count} Einträge}}'**
  String itemCount(int count);

  /// Sprache Label
  ///
  /// In de, this message translates to:
  /// **'Sprache'**
  String get language;

  /// Design/Theme Label
  ///
  /// In de, this message translates to:
  /// **'Design'**
  String get theme;

  /// Dunkelmodus Label
  ///
  /// In de, this message translates to:
  /// **'Dunkelmodus'**
  String get darkMode;

  /// Hellmodus Label
  ///
  /// In de, this message translates to:
  /// **'Hellmodus'**
  String get lightMode;
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
