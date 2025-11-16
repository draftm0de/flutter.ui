# DraftMode UI Dialog

A platform-aware confirmation dialog widget with an optional auto-confirm
countdown. The `DraftModeUIDialog.show` helper renders
`CupertinoAlertDialog` on iOS and `AlertDialog` elsewhere while keeping the
behavior consistent across platforms.

## Installation

Add the package to your `pubspec.yaml` as a path or git dependency and include
the shared localization package:

```yaml
dependencies:
  draftmode_ui:
    path: ../ui
  draftmode_localization:
    path: ../localization
  flutter_localizations:
    sdk: flutter
```

Run `flutter pub get` after updating the file.

## Localization Setup

Localization ARB sources now live in the dedicated
`draftmode_localization` repository/package. Import
`package:draftmode_localization/localizations.dart` and enable the generated
delegates in your host app:

```dart
return MaterialApp(
  localizationsDelegates: DraftModeLocalizations.localizationsDelegates,
  supportedLocales: DraftModeLocalizations.supportedLocales,
  home: const MyHomePage(),
);
```

The dialog falls back to `Yes`/`No` labels (and English countdown text) if the
localization context is missing, which keeps integration tests and minimal host
apps simple. If you need additional locales, add them to the localization
package and pull the updated dependency.

## Usage

```dart
final confirmed = await DraftModeUIDialog.show(
  context: context,
  title: 'Discard changes?',
  message: 'You have unsaved edits.',
  autoConfirm: const Duration(seconds: 5),
  mode: DraftModeUIDialogStyle.error,
);

if (confirmed == true) {
  // Perform the destructive action.
}
```

Pass `DraftModeUIDialogStyle.error` to hide the cancel button and show a
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
package and verify 100% line coverage for `lib/ui/dialog.dart`.

## Contributing

1. Update the ARB resources in the `draftmode_localization` package when
   introducing user-facing strings.
2. Run `flutter test --coverage`.
3. Submit PRs with a concise summary of behavior changes and test results.
