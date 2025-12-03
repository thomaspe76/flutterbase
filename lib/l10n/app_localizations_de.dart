// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'FlutterBase';

  @override
  String get welcome => 'Willkommen';

  @override
  String get welcomeMessage =>
      'Willkommen bei FlutterBase - Eine professionell strukturierte Flutter App';

  @override
  String get home => 'Startseite';

  @override
  String get settings => 'Einstellungen';

  @override
  String get profile => 'Profil';

  @override
  String get signIn => 'Anmelden';

  @override
  String get signUp => 'Registrieren';

  @override
  String get signOut => 'Abmelden';

  @override
  String get email => 'E-Mail';

  @override
  String get password => 'Passwort';

  @override
  String get confirmPassword => 'Passwort bestätigen';

  @override
  String get forgotPassword => 'Passwort vergessen?';

  @override
  String get save => 'Speichern';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get search => 'Suchen';

  @override
  String get loading => 'Lädt...';

  @override
  String get error => 'Fehler';

  @override
  String get success => 'Erfolgreich';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get noDataAvailable => 'Keine Daten verfügbar';

  @override
  String get somethingWentWrong => 'Etwas ist schiefgelaufen';

  @override
  String get emailRequired => 'E-Mail ist erforderlich';

  @override
  String get emailInvalid => 'Ungültige E-Mail-Adresse';

  @override
  String get passwordRequired => 'Passwort ist erforderlich';

  @override
  String passwordTooShort(int minLength) {
    return 'Passwort muss mindestens $minLength Zeichen lang sein';
  }

  @override
  String get passwordsDoNotMatch => 'Passwörter stimmen nicht überein';

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Einträge',
      one: '1 Eintrag',
      zero: 'Keine Einträge',
    );
    return '$_temp0';
  }

  @override
  String get language => 'Sprache';

  @override
  String get theme => 'Design';

  @override
  String get darkMode => 'Dunkelmodus';

  @override
  String get lightMode => 'Hellmodus';
}
