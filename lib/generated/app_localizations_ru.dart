import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get please_check_your_connection => 'Пожалуйста, проверьте ваше соединение';

  @override
  String get server_error => 'Ошибка сервера';

  @override
  String get access_to_location_denied => 'Доступ к местоположению запрещен';

  @override
  String get allow_access_to_the_location_services => 'Разрешить доступ к службам определения местоположения.';

  @override
  String get access_to_location_permanently_denied => 'Доступ к местоположению запрещен навсегда';

  @override
  String get allow_access_to_the_location_services_from_settings => 'Разрешите доступ к службам определения местоположения для этого приложения в настройках устройства.';

  @override
  String get ok => 'ОК';

  @override
  String get cant_get_current_location => 'Невозможно получить текущее местоположение';

  @override
  String get please_make_sure_you_enable_gps_and_try_again => 'Пожалуйста, убедитесь, что вы включили GPS и попробуйте снова';

  @override
  String get search_place => 'Поиск места';

  @override
  String get finding_place => 'Finding place...';

  @override
  String get no_result_found => 'No result found';

  @override
  String get unnamedPlace => 'Место без названия';
}
