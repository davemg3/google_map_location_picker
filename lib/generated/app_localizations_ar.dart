import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get please_check_your_connection => 'تأكد من وجود انترنت';

  @override
  String get server_error => 'خطأ من الخادم حاول مرة اخري';

  @override
  String get access_to_location_denied => 'تم رفض إذن الوصل الي الموقع الجغرافي';

  @override
  String get allow_access_to_the_location_services => 'من فضلك قم بقبول إذن الوصول الي الموقع الجغرافي';

  @override
  String get access_to_location_permanently_denied => 'تم رفض إذن الوصل الي الموقع الجغرافي بشكل نهائي';

  @override
  String get allow_access_to_the_location_services_from_settings => 'من فضلك قم بقبول إذن الوصول الي الموقع الجغرافي من إدادات التطبيق.';

  @override
  String get ok => 'حسنا';

  @override
  String get cant_get_current_location => 'لا يمكن الحصول علي الموقع الجغرافي الحالي';

  @override
  String get please_make_sure_you_enable_gps_and_try_again => 'الرجاء التاكد من تفعيل الـGPS و المحاولة مرة أخري';

  @override
  String get search_place => 'إبحث بإسم المكان';

  @override
  String get finding_place => 'جاري البحث...';

  @override
  String get no_result_found => 'لم يتم العثور على نتائج';

  @override
  String get unnamedPlace => 'مكان بدون اسم';
}
