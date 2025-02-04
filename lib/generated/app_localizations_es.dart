import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get please_check_your_connection => 'Por favor, verifique su conexión';

  @override
  String get server_error => 'Error del servidor';

  @override
  String get access_to_location_denied => 'Acceso a la ubicación denegado';

  @override
  String get allow_access_to_the_location_services => 'Permitir acceso a los servicios de ubicación';

  @override
  String get access_to_location_permanently_denied => 'Acceso a la ubicación denegado permanentemente';

  @override
  String get allow_access_to_the_location_services_from_settings => 'Permita el acceso a los servicios de ubicación para esta aplicación usando la configuración del dispositivo.';

  @override
  String get ok => 'Ok';

  @override
  String get cant_get_current_location => 'No se puede obtener la ubicación actual';

  @override
  String get please_make_sure_you_enable_gps_and_try_again => 'Asegúrese de habilitar el GPS y vuelva a intentarlo';

  @override
  String get search_place => 'Buscar lugar';

  @override
  String get finding_place => 'Buscando lugar ...';

  @override
  String get no_result_found => 'No se encontraron resultados';

  @override
  String get unnamedPlace => 'Lugar sin nombre';
}
