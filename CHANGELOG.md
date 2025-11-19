# Changelog

## Unreleased

## 1.0.1+1
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
