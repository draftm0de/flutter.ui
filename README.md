# DraftMode UI Components

Reusable Flutter widgets shared across DraftMode apps. The package currently
ships the platform-aware `DraftModeUIDialog`, grouped form building blocks
(`DraftModeUIRow`, `DraftModeUISection`, and `DraftModeUIList`), the page
scaffolding family, and a `DraftModeUIPageExample` demo scaffold that showcases
the bundled assets.

### Library entrypoints

- `package:draftmode_ui/components.dart` – dialog helpers plus shared form rows
  and sections.
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

## DraftModeUIRow

`DraftModeUIRow` standardizes the grouped form-row layout used throughout
DraftMode surfaces. When a `label` is provided the widget renders a
`DraftModeUIStyles.labelWidth`-wide leading column (or the width inherited from
`DraftModeUISection`) with `DraftModeUIStyleText` typography before expanding
the trailing child. Padding defaults to the shared `DraftModeUIStylePadding`
tokens so adjacent rows visually align with the rest of the library.

```dart
import 'package:draftmode_ui/components.dart';

DraftModeUIRow(
  CupertinoTextField(placeholder: 'Email'),
  label: 'Email',
  backgroundColor: CupertinoColors.secondarySystemGroupedBackground,
);
```

Override `padding`, `alignment`, `height`, or `backgroundColor` to match custom
grouped list treatments. Use `DraftModeUIStyles.labelWidth` for global tuning
or the new `DraftModeUISection.labelWidth` parameter for per-section overrides.

## DraftModeUISection

`DraftModeUISection` groups one or more rows into a platform-adaptive container
that mirrors native grouped lists. On iOS it proxies to
`CupertinoListSection.insetGrouped`; elsewhere, it renders a rounded `Card`
with optional headers. Sections propagate their `labelWidth` to descendant
`DraftModeUIRow` instances via `DraftModeUISectionScope`, making it easy to
align multiple sections with different layouts on the same screen.

```dart
DraftModeUISection(
  header: 'Contact details',
  labelWidth: 120,
  children: const [
    DraftModeUIRow(Text('support@draftmode.com'), label: 'Email'),
    DraftModeUIRow(Text('+1 (415) 555-1234'), label: 'Phone'),
  ],
);
```

Set `transparent: true` to reuse grouped spacing without painting the default
Cupertino background.

## DraftModeUIList

`DraftModeUIList` renders tappable grouped lists that reuse the shared row
layout plus selection badges. Feed it strongly typed domain objects or the
convenience `DraftModeListItem` class, provide an `itemBuilder`, and optionally
wire up pull-to-refresh or placeholder states:

```dart
final items = DraftModeListItemBuilder.fromMap({
  1: 'Personal',
  2: 'Work',
});

DraftModeUIList<DraftModeListItem>(
  items: items,
  selectedItem: items.first,
  header: const DraftModeUIRow(Text('Destination')),
  emptyPlaceholder: const Text('No matches'),
  onRefresh: () async => _reload(),
  itemBuilder: (item, isSelected) => Text(item.value),
  onTap: (item) => _select(item),
);
```

When `selectedItem` matches an element by identity a trailing checkmark is
rendered automatically. Supplying `onRefresh` switches to a
`CustomScrollView`/`CupertinoSliverRefreshControl` pair without additional
plumbing, and `emptyPlaceholder` gets wrapped in a `DraftModeUIRow` so empty
states still align with the rest of the grouped UI. When `separator` is
omitted the widget paints a Cupertino-style divider that mimics inset grouped
lists; pass a custom widget (or `SizedBox.shrink()`) to override or remove that
default treatment.

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

## Example App

The `/example` directory embeds a runnable Flutter app that wires
`DraftModeUIPage`, `DraftModeUISection`, and `DraftModeUIRow` together. Use it
as a quick-start template or a visual reference when composing complex forms:

```
cd example
flutter run
```

`main.dart` demonstrates the `DraftModeUIStyles.labelWidth` override while the
home screen showcases labelled and unlabelled rows rendered inside multiple
sections.

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
- `DraftModeUIStylePadding`, `DraftModeUIStyleNavigationBar`,
  `DraftModeUIStyleColor`, `DraftModeUIStyleText`, and
  `DraftModeUIStyleIconSize` centralize spacing, typography, sizing, and colour
  tokens that you can reuse across custom DraftMode widgets. Use
  `DraftModeUIStyles.labelWidth` when composing labelled rows so they align with
  the stock components.

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
