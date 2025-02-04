import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get please_check_your_connection => 'Please check your connection';

  @override
  String get server_error => 'Server error';

  @override
  String get access_to_location_denied => 'Access to location denied';

  @override
  String get allow_access_to_the_location_services => 'Allow access to the location services.';

  @override
  String get access_to_location_permanently_denied => 'Access to location permanently denied';

  @override
  String get allow_access_to_the_location_services_from_settings => 'Allow access to the location services for this App using the device settings.';

  @override
  String get ok => 'Ok';

  @override
  String get cant_get_current_location => 'Can\'t get current location';

  @override
  String get please_make_sure_you_enable_gps_and_try_again => 'Please make sure you enable GPS and try again';

  @override
  String get search_place => 'Search place';

  @override
  String get finding_place => 'Finding place...';

  @override
  String get no_result_found => 'No result found';

  @override
  String get unnamedPlace => 'Unnamed place';
}
