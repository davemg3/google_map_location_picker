import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get please_check_your_connection => 'Lütfen bağlantınızı kontrol edin';

  @override
  String get server_error => 'Sunucu hatası';

  @override
  String get access_to_location_denied => 'Konum erişimi reddedildi';

  @override
  String get allow_access_to_the_location_services => 'Konum servislerine izin verin.';

  @override
  String get access_to_location_permanently_denied => 'Konuma erişim kalıcı olarak reddedildi';

  @override
  String get allow_access_to_the_location_services_from_settings => 'Cihaz ayarlarını kullanarak bu Uygulama için konum hizmetlerine erişime izin verin.';

  @override
  String get ok => 'Tamam';

  @override
  String get cant_get_current_location => 'Geçerli konum alınamıyor';

  @override
  String get please_make_sure_you_enable_gps_and_try_again => 'Lütfen GPS’i etkinleştirin ve tekrar deneyin.';

  @override
  String get search_place => 'Konum ara';

  @override
  String get finding_place => 'Yer aranıyor...';

  @override
  String get no_result_found => 'Sonuç Bulunamadı';

  @override
  String get unnamedPlace => 'Adsız yer';
}
