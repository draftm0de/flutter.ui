# Changelog

## 1.0.8+1
- Added an `expanded` slot to `DraftModeUIRow` so trailing badges/buttons render
  beside the primary content without manual padding tweaks. Updated inline docs,
  README guidance, the home example, and new widget tests to lock in the
  behavior while keeping suite coverage at 100%.
- Exercised the default styling branch of `DraftModeUIButton.text` and both the
  Cupertino/Material navigation paths inside `DraftModeUIDropDown` so coverage
  stays perfect across the factory helpers and picker routing logic.

## 1.0.7+1
- Added the adaptive `DraftModeUISwitch` platform control plus exhaustive tests
  to lock down the Cupertino/Material render paths and default value behavior.
- Documented the new widget in the README and showcased it on the example
  screen so host apps can mirror the native toggle affordance without branching
  per platform.

## 1.0.6+1
- Added the `DraftModeUIButton.text` factory to render buttons backed by DraftMode
  text sizing/tint tokens without manually constructing a `Text` widget.
- Introduced `DraftModeUIDropDown`, documented the API, and updated the example
  screen/tests to showcase the full-screen picker flow that reuses
  `DraftModeUIList` hooks.

## 1.0.5+1
- Extended `DraftModeUIPageExample` with navigation/bottom bar overrides plus
  refreshed documentation and tests to cover the new configuration surface.
- Normalized `DraftModeUIList` default padding to `EdgeInsets.zero` and added
  dialog coverage for `DraftModeUIShowDialog` to hold the suite at 100%.

## 1.0.4+1
- Added `DraftModeUIList` default separators that mirror Cupertino inset-grouped
  dividers when no custom separator is provided, updated inline docs/README, and
  expanded tests/coverage to keep the behavior locked in.
- Added the page scaffolding library, including `DraftModeUIPage`, navigation
  bars, and navigation items backed by platform-aware defaults.
- Introduced shared `DraftModeUIStyle*` spacing/colour tokens plus
  `DraftModeUIButton`/`DraftModeUIPlatform` helpers for consistent iconography.
- Moved `DraftModeUIDialog` into `lib/components/dialog.dart` and kept the
  package exports aligned through `lib/components.dart` and `lib/pages.dart`.
- Added the `DraftModeUIPageExample` widget and bundled DraftMode branding
  assets for demos.
- Introduced `DraftModeUIRow` plus supporting text/icon/label tokens in
  `draftmode_ui/styles.dart` for consistent grouped form rows.
- Added `DraftModeUISection` to containerize grouped form rows and propagate
  label widths plus an `/example` reference app that wires all widgets together.
- Expanded the widget and unit test suite to cover the scaffolds, navigation
  items, icons, and documentation helpers.

## 1.0.0+1
- Renamed the public surface to the `DraftModeUIDialog` API to match the new `lib/ui.dart` export.
- Documented that localized strings now flow from the external `draftmode_localization` package instead of the old `lib/l10n` assets.
