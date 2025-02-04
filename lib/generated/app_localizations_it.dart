import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get please_check_your_connection => 'Controlla la tua connessione di rete';

  @override
  String get server_error => 'Errore del server';

  @override
  String get access_to_location_denied => 'Accesso alla posizione rifiutato';

  @override
  String get allow_access_to_the_location_services => 'Permetti l\'accesso ai servizi di localizzazione.';

  @override
  String get access_to_location_permanently_denied => 'Accesso alla posizione rifiutato permanentemente';

  @override
  String get allow_access_to_the_location_services_from_settings => 'Consenti l\'accesso ai servizi di localizzazione per questa app utilizzando le impostazioni del dispositivo.';

  @override
  String get ok => 'Ok';

  @override
  String get cant_get_current_location => 'Impossibile ottenere la posizione attuale';

  @override
  String get please_make_sure_you_enable_gps_and_try_again => 'Assicurati di aver attivato il GPS e prova di nuovo';

  @override
  String get search_place => 'Ricerca luogo';

  @override
  String get finding_place => 'Cercando il luogo...';

  @override
  String get no_result_found => 'Nessun risultato trovato';

  @override
  String get unnamedPlace => 'Località senza nome';
}
