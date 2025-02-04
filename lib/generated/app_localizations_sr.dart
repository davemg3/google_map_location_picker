import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Serbian (`sr`).
class AppLocalizationsSr extends AppLocalizations {
  AppLocalizationsSr([String locale = 'sr']) : super(locale);

  @override
  String get please_check_your_connection => 'Proverite svoju internet konekciju';

  @override
  String get server_error => 'Greška na serveru.';

  @override
  String get access_to_location_denied => 'Onemogućen pristup lokaciji';

  @override
  String get allow_access_to_the_location_services => 'Omogućite pristup Vašoj lokaciji';

  @override
  String get access_to_location_permanently_denied => 'Access to location permanently denied';

  @override
  String get allow_access_to_the_location_services_from_settings => 'Allow access to the location services for this App using the device settings.';

  @override
  String get ok => 'U redu';

  @override
  String get cant_get_current_location => 'Ne možemo da pristupimo Vašoj lokaciji, pokušajte ponovo';

  @override
  String get please_make_sure_you_enable_gps_and_try_again => 'Proverite da li ste omogućili GPS i pokušajte ponovo';

  @override
  String get search_place => 'Pretraži';

  @override
  String get finding_place => 'Pronalaženje mesta ...';

  @override
  String get no_result_found => 'Nema rezultata';

  @override
  String get unnamedPlace => 'Unnamed place';
}
