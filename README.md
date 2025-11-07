# DraftMode UI Dialog

A platform-aware confirmation dialog widget with optional auto-confirm countdown
and Flutter gen-l10n integration. The component exposes a static `show`
helper that automatically renders `CupertinoAlertDialog` on iOS and
`AlertDialog` elsewhere while keeping behavior consistent across platforms.

## Installation

Add the package to your `pubspec.yaml` as a path or git dependency and make
sure Flutter's localization packages are enabled:

```yaml
dependencies:
  draftmode_ui_dialog:
    path: ../ui.dialog
  flutter_localizations:
    sdk: flutter
  intl: any
```

Run `flutter pub get` after updating the file.

## Localization Setup

1. Ensure `flutter generate` is enabled in your `pubspec.yaml`.
2. Update `l10n.yaml` if you need to change the arb directory or template file.
3. Add your localized strings to `lib/l10n/*.arb` and run `flutter gen-l10n`.
4. In your application root, wire the generated delegates:

```dart
return MaterialApp(
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: const MyHomePage(),
);
```

The dialog falls back to `Yes`/`No` labels (and English countdown text) if the
localization context is missing, which makes it safe for integration tests or
minimal host apps.

## Usage

```dart
final confirmed = await DraftModeUIConfirm.show(
  context: context,
  title: 'Discard changes?',
  message: 'You have unsaved edits.',
  autoConfirm: const Duration(seconds: 5),
  mode: DraftModeUIConfirmStyle.error,
);

if (confirmed == true) {
  // Perform the destructive action.
}
```

Pass `DraftModeUIConfirmStyle.error` to hide the cancel button and show a
red accent on Material buttons.

### Auto-confirm Countdown

Providing `autoConfirm` starts a countdown timer. The widget displays the
remaining time using the localized `autoConfirmCountdown` message and
automatically closes when the timer reaches zero.

- Durations `<= Duration.zero` trigger an immediate confirmation on the next
  frame.
- Positive durations schedule one-second ticks using `Timer.periodic`.

## Testing

Run `flutter test --coverage` to execute the widget tests included with this
package and verify 100% line coverage for `lib/dialog.dart`.

## Contributing

1. Update or add ARB resources when introducing user-facing strings.
2. Run `flutter gen-l10n` and `flutter test --coverage`.
3. Submit PRs with a concise summary of behavior changes and test results.
