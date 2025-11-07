import 'package:draftmode_ui_dialog/l10n/app_localizations.dart';
import 'package:draftmode_ui_dialog/l10n/app_localizations_de.dart';
import 'package:draftmode_ui_dialog/l10n/app_localizations_en.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppLocalizations delegate', () {
    test('loads supported locales', () async {
      final en = await AppLocalizations.delegate.load(const Locale('en'));
      final de = await AppLocalizations.delegate.load(const Locale('de'));

      expect(en, isA<AppLocalizationsEn>());
      expect(de, isA<AppLocalizationsDe>());
    });

    test('shouldReload always returns false', () async {
      final delegate = AppLocalizations.delegate;
      final shouldReload = (delegate as dynamic).shouldReload(delegate);
      expect(shouldReload, isFalse);
    });

    test('lookup throws for unsupported locales', () {
      expect(() => lookupAppLocalizations(const Locale('fr')), throwsFlutterError);
    });
  });

  group('Generated translations', () {
    test('german strings', () {
      final locale = AppLocalizationsDe();
      expect(locale.btnConfirmNo, 'Nein');
      expect(locale.btnConfirmYes, 'Ja');
      expect(locale.autoConfirmCountdown('00:10'), 'automatische Bestätigung in 00:10');
    });

    test('english strings', () {
      final locale = AppLocalizationsEn();
      expect(locale.btnConfirmNo, 'No');
      expect(locale.btnConfirmYes, 'Yes');
      expect(locale.autoConfirmCountdown('00:10'), 'Automatically confirms in 00:10');
    });
  });
}
