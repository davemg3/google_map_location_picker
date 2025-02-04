import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get please_check_your_connection => 'Por favor, verifique sua conexão';

  @override
  String get server_error => 'Erro de servidor';

  @override
  String get access_to_location_denied => 'Acesso ao local negado';

  @override
  String get allow_access_to_the_location_services => 'Permitir acesso aos serviços de localização.';

  @override
  String get access_to_location_permanently_denied => 'Acesso ao local negado permanentemente';

  @override
  String get allow_access_to_the_location_services_from_settings => 'Permita o acesso aos serviços de localização para este aplicativo usando as configurações do dispositivo.';

  @override
  String get ok => 'Ok';

  @override
  String get cant_get_current_location => 'Não é possível obter a localização atual';

  @override
  String get please_make_sure_you_enable_gps_and_try_again => 'Certifique-se de ativar o GPS e tente novamente';

  @override
  String get search_place => 'Pesquisar endereço';

  @override
  String get finding_place => 'Finding place...';

  @override
  String get no_result_found => 'No result found';

  @override
  String get unnamedPlace => 'Lugar sem nome';
}
