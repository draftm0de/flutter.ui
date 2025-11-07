import 'package:draftmode_ui/l10n/app_localizations.dart';
import 'package:draftmode_ui/l10n/app_localizations_de.dart';
import 'package:draftmode_ui/l10n/app_localizations_en.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DraftModeUILocalizations delegate', () {
    test('loads supported locales', () async {
      final en = await DraftModeUILocalizations.delegate.load(
        const Locale('en'),
      );
      final de = await DraftModeUILocalizations.delegate.load(
        const Locale('de'),
      );

      expect(en, isA<DraftModeUILocalizationsEn>());
      expect(de, isA<DraftModeUILocalizationsDe>());
    });

    test('shouldReload always returns false', () async {
      final delegate = DraftModeUILocalizations.delegate;
      final shouldReload = (delegate as dynamic).shouldReload(delegate);
      expect(shouldReload, isFalse);
    });

    test('lookup throws for unsupported locales', () {
      expect(
        () => lookupDraftModeUILocalizations(const Locale('fr')),
        throwsFlutterError,
      );
    });
  });

  group('Generated translations', () {
    test('german strings', () {
      final locale = DraftModeUILocalizationsDe();
      expect(locale.btnConfirmNo, 'Nein');
      expect(locale.btnConfirmYes, 'Ja');
      expect(
        locale.autoConfirmCountdown(time: '00:10'),
        'automatische Bestätigung in 00:10',
      );
    });

    test('english strings', () {
      final locale = DraftModeUILocalizationsEn();
      expect(locale.btnConfirmNo, 'No');
      expect(locale.btnConfirmYes, 'Yes');
      expect(
        locale.autoConfirmCountdown(time: '00:10'),
        'Automatically confirms in 00:10',
      );
    });
  });
}
