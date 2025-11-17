# DraftMode UI Components

Reusable Flutter widgets shared across DraftMode apps. The package currently
ships the platform-aware `DraftModeUIDialog`, the page scaffolding family, and
a `DraftModeUIPageExample` demo scaffold that showcases the bundled assets.

### Library entrypoints

- `package:draftmode_ui/components.dart` – dialog helpers.
- `package:draftmode_ui/pages.dart` – page scaffolds, navigation bars and
  navigation item widgets.
- `package:draftmode_ui/buttons.dart` – platform-aware icon tokens via `DraftModeUIButton`.
- `package:draftmode_ui/styles.dart` – shared spacing/colour tokens.
- `package:draftmode_ui/platform.dart` – `DraftModeUIPlatform.isIOS` helper.

## Installation

Add the package to your `pubspec.yaml` as a path or git dependency and include
the shared localization package:

```yaml
dependencies:
  draftmode_ui:
    path: ../component
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

## DraftModeUIDialog

A platform-aware confirmation dialog widget with an optional auto-confirm
countdown. The `DraftModeUIDialog.show` helper renders
`CupertinoAlertDialog` on iOS and `AlertDialog` elsewhere while keeping the
behavior consistent across platforms.

### Usage

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

## DraftModeUIPage

`DraftModeUIPage` encapsulates shared scaffolding conventions for DraftMode
screens. It renders a platform-aware navigation bar, includes an automatic save
action when `onSavePressed` is provided, and anchors optional controls in a
Cupertino-style bottom bar.

```dart
import 'package:draftmode_ui/pages.dart';
import 'package:draftmode_ui/buttons.dart';

DraftModeUIPage(
  navigationTitle: 'Upload files',
  topLeadingText: 'Close',
  onSavePressed: () async {
    await _save();
    return true; // dismiss when succeeded
  },
  bottomLeading: const [
    DraftModePageNavigationBottomItem(icon: CupertinoIcons.photo),
    DraftModePageNavigationBottomItem(icon: CupertinoIcons.folder),
  ],
  bottomCenter: const DraftModePageNavigationBottomItem(icon: CupertinoIcons.play_arrow_solid),
  bottomTrailing: const [
    DraftModePageNavigationBottomItem(icon: CupertinoIcons.search),
  ],
  body: const Text('Primary content goes here'),
);
```

Use `horizontalContainerPadding`/`verticalContainerPadding` and
`containerBackgroundColor` to align the host app styling, or inject custom
`DraftModePageNavigationTopItem`/`DraftModePageNavigationBottomItem` instances
to override the automatic controls.

## DraftModeUIPageExample

`DraftModeUIPageExample` wraps demo widgets in a `CupertinoPageScaffold` with a
DraftMode-branded header. Pass a title plus a list of children to display below
the header card.

```dart
return const DraftModeUIPageExample(
  title: 'Dialog gallery',
  children: [
    DraftModeDialogDemo(),
    SizedBox(height: 24),
    DraftModeAnotherWidget(),
  ],
);
```

The header renders `assets/images/logo.png` bundled with this package.

## Navigation helpers

`DraftModePageNavigationItem` is a shared button component used by the top and
bottom bars. It automatically switches between `CupertinoButton` and
`TextButton`, and it can either call a callback (`onTap`) or push a new route
(`loadWidget`). The `DraftModePageNavigationTopItem` and
`DraftModePageNavigationBottomItem` wrappers pre-configure sizing for their
respective bars so you only need to provide icons/text.

## Platform buttons & styles

- `DraftModeUIButton` exposes platform-specific `IconData` for standard actions
  (back, save, logout, etc.) so downstream widgets stay idiomatic.
- `DraftModeUIPlatform.isIOS` mirrors Flutter's `defaultTargetPlatform` to keep
  conditional code consistent across widgets.
- `DraftModeUIStylePadding`, `DraftModeUIStyleNavigationBar`, and
  `DraftModeUIStyleColor` centralize spacing, sizing, and colour tokens that you
  can reuse across custom DraftMode widgets.

## Assets

The `assets/images/logo.png` asset is exported for downstream packages. When
referencing it directly, include the `package` argument so Flutter looks inside
the dependency bundle:

```dart
Image.asset('assets/images/logo.png', package: 'draftmode_ui');
```

## Testing

Run `flutter test --coverage` to execute the widget tests and verify the dialog,
page scaffolds, navigation helpers, and tokens maintain full coverage.

## Contributing

1. Update the ARB resources in the `draftmode_localization` package when
   introducing user-facing strings.
2. Run `flutter test --coverage`.
3. Submit PRs with a concise summary of behavior changes and test results.
