import 'dart:async';

import 'package:draftmode_ui/confirm.dart';
import 'package:draftmode_ui/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DraftModeUIConfirm.show', () {
    testWidgets(
      'shows Material dialog with localized labels and returns selection',
      (tester) async {
        await _withTargetPlatform(TargetPlatform.android, () async {
          final result = ValueNotifier<bool?>(null);

          await tester.pumpWidget(
            _TestApp(
              result: result,
              autoConfirm: null,
              mode: DraftModeUIConfirmStyle.confirm,
              provideLocalization: true,
            ),
          );

          await tester.tap(find.byKey(_TestApp.launchKey));
          await tester.pumpAndSettle();

          expect(find.byType(AlertDialog), findsOneWidget);
          expect(find.text('Yes'), findsOneWidget);
          expect(find.text('No'), findsOneWidget);

          await tester.tap(find.text('No'));
          await tester.pumpAndSettle();

          expect(result.value, isFalse);
        });
      },
    );

    testWidgets(
      'auto confirm countdown uses localization and resolves after timer',
      (tester) async {
        await _withTargetPlatform(TargetPlatform.android, () async {
          final result = ValueNotifier<bool?>(null);

          await tester.pumpWidget(
            _TestApp(
              result: result,
              autoConfirm: const Duration(seconds: 2),
              mode: DraftModeUIConfirmStyle.confirm,
              provideLocalization: true,
            ),
          );

          await tester.tap(find.byKey(_TestApp.launchKey));
          await tester.pumpAndSettle();

          expect(
            find.textContaining('Automatically confirms in 00:02'),
            findsOneWidget,
          );

          await tester.pump(const Duration(seconds: 2));
          await tester.pumpAndSettle();

          expect(result.value, isTrue);
          expect(find.byType(AlertDialog), findsNothing);
        });
      },
    );

    testWidgets('error mode hides cancel button', (tester) async {
      await _withTargetPlatform(TargetPlatform.android, () async {
        final result = ValueNotifier<bool?>(null);

        await tester.pumpWidget(
          _TestApp(
            result: result,
            autoConfirm: null,
            mode: DraftModeUIConfirmStyle.error,
            provideLocalization: true,
          ),
        );

        await tester.tap(find.byKey(_TestApp.launchKey));
        await tester.pumpAndSettle();

        expect(find.text('No'), findsNothing);
        expect(find.text('Yes'), findsOneWidget);

        await tester.tap(find.text('Yes'));
        await tester.pumpAndSettle();

        expect(result.value, isTrue);
      });
    });

    testWidgets('cupertino dialog path renders CupertinoAlertDialog', (
      tester,
    ) async {
      await _withTargetPlatform(TargetPlatform.iOS, () async {
        final result = ValueNotifier<bool?>(null);

        await tester.pumpWidget(
          _TestApp(
            result: result,
            autoConfirm: null,
            mode: DraftModeUIConfirmStyle.confirm,
            provideLocalization: true,
          ),
        );

        await tester.tap(find.byKey(_TestApp.launchKey));
        await tester.pumpAndSettle();

        expect(find.byType(CupertinoAlertDialog), findsOneWidget);

        await tester.tap(find.text('No'));
        await tester.pumpAndSettle();

        expect(result.value, isFalse);

        await tester.tap(find.byKey(_TestApp.launchKey));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Yes'));
        await tester.pumpAndSettle();

        expect(result.value, isTrue);
      });
    });

    testWidgets(
      'auto confirm duration <= 0 resolves immediately on next frame',
      (tester) async {
        await _withTargetPlatform(TargetPlatform.android, () async {
          final result = ValueNotifier<bool?>(null);

          await tester.pumpWidget(
            _TestApp(
              result: result,
              autoConfirm: Duration.zero,
              mode: DraftModeUIConfirmStyle.confirm,
              provideLocalization: true,
              showImmediately: true,
            ),
          );

          await tester.pump();
          await tester.pumpAndSettle();

          expect(result.value, isTrue);
          expect(find.byType(AlertDialog), findsNothing);
        });
      },
    );

    testWidgets(
      'falls back to default strings when localization context missing',
      (tester) async {
        await _withTargetPlatform(TargetPlatform.android, () async {
          final result = ValueNotifier<bool?>(null);

          await tester.pumpWidget(
            _TestApp(
              result: result,
              autoConfirm: const Duration(seconds: 1),
              mode: DraftModeUIConfirmStyle.confirm,
              provideLocalization: false,
            ),
          );

          await tester.tap(find.byKey(_TestApp.launchKey));
          await tester.pumpAndSettle();

          expect(find.text('Yes'), findsOneWidget);
          expect(find.text('No'), findsOneWidget);
          expect(
            find.textContaining('Automatically confirms in 00:01'),
            findsOneWidget,
          );
        });
      },
    );
  });
}

Future<void> _withTargetPlatform(
  TargetPlatform platform,
  Future<void> Function() body,
) async {
  final previous = debugDefaultTargetPlatformOverride;
  debugDefaultTargetPlatformOverride = platform;
  try {
    await body();
  } finally {
    debugDefaultTargetPlatformOverride = previous;
  }
}

class _TestApp extends StatelessWidget {
  const _TestApp({
    required this.result,
    required this.autoConfirm,
    required this.mode,
    required this.provideLocalization,
    this.showImmediately = false,
  });

  final ValueNotifier<bool?> result;
  final Duration? autoConfirm;
  final DraftModeUIConfirmStyle mode;
  final bool provideLocalization;
  final bool showImmediately;

  static const launchKey = Key('launch-dialog');

  @override
  Widget build(BuildContext context) {
    final home = _DialogLauncher(
      result: result,
      autoConfirm: autoConfirm,
      mode: mode,
      showImmediately: showImmediately,
    );

    return MaterialApp(
      localizationsDelegates: provideLocalization
          ? DraftModeUILocalizations.localizationsDelegates
          : const <LocalizationsDelegate<dynamic>>[],
      supportedLocales: provideLocalization
          ? DraftModeUILocalizations.supportedLocales
          : const <Locale>[Locale('en')],
      home: home,
    );
  }
}

class _DialogLauncher extends StatefulWidget {
  const _DialogLauncher({
    required this.result,
    required this.autoConfirm,
    required this.mode,
    required this.showImmediately,
  });

  final ValueNotifier<bool?> result;
  final Duration? autoConfirm;
  final DraftModeUIConfirmStyle mode;
  final bool showImmediately;

  @override
  State<_DialogLauncher> createState() => _DialogLauncherState();
}

class _DialogLauncherState extends State<_DialogLauncher> {
  @override
  void initState() {
    super.initState();
    if (widget.showImmediately) {
      scheduleMicrotask(_launchDialog);
    }
  }

  Future<void> _launchDialog() async {
    final choice = await DraftModeUIConfirm.show(
      context: context,
      title: 'Confirm',
      message: 'Do the thing?',
      mode: widget.mode,
      autoConfirm: widget.autoConfirm,
    );
    widget.result.value = choice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          key: _TestApp.launchKey,
          onPressed: _launchDialog,
          child: const Text('Launch'),
        ),
      ),
    );
  }
}
