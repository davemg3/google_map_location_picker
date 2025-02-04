import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get please_check_your_connection => 'Prüfe deine Internetverbindung';

  @override
  String get server_error => 'Server Fehler';

  @override
  String get access_to_location_denied => 'Zugriff auf Standort verweigert';

  @override
  String get allow_access_to_the_location_services => 'Erlaube Zugriff auf Standort';

  @override
  String get access_to_location_permanently_denied => 'Zugriff auf Standort permanent verweigert';

  @override
  String get allow_access_to_the_location_services_from_settings => 'Erlaube den Zugriff auf den Standort über die Geräteeinstellungen.';

  @override
  String get ok => 'Ok';

  @override
  String get cant_get_current_location => 'Standort kann nicht abgefragt werden.';

  @override
  String get please_make_sure_you_enable_gps_and_try_again => 'Stelle sicher das GPS aktiviert ist und probier es nochmal';

  @override
  String get search_place => 'Suche Ort';

  @override
  String get finding_place => 'Finde Orte...';

  @override
  String get no_result_found => 'Keine Ergebnisse';

  @override
  String get unnamedPlace => 'unbekannter Ort';
}
