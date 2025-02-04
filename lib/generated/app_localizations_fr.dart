import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get please_check_your_connection => 'Veuillez vérifier votre connexion';

  @override
  String get server_error => 'Erreur du serveur';

  @override
  String get access_to_location_denied => 'Accès à l\'emplacement refusé';

  @override
  String get allow_access_to_the_location_services => 'Autoriser l\'accès aux services de localisation.';

  @override
  String get access_to_location_permanently_denied => 'Accès à l\'emplacement refusé définitivement';

  @override
  String get allow_access_to_the_location_services_from_settings => 'Autorisez l\'accès aux services de localisation pour cette application à l\'aide des paramètres de l\'appareil.';

  @override
  String get ok => 'D\'accord';

  @override
  String get cant_get_current_location => 'Impossible d\'obtenir l\'emplacement actuel';

  @override
  String get please_make_sure_you_enable_gps_and_try_again => 'Veuillez vous assurer d\'activer le GPS et de réessayer';

  @override
  String get search_place => 'Rechercher un lieu';

  @override
  String get finding_place => 'En train de trouver un lieu...';

  @override
  String get no_result_found => 'Aucun résultat trouvé';

  @override
  String get unnamedPlace => 'Luogo senza nome';
}
