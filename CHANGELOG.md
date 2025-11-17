# Changelog

## Unreleased
- Added the page scaffolding library, including `DraftModeUIPage`, navigation
  bars, and navigation items backed by platform-aware defaults.
- Introduced shared `DraftModeUIStyle*` spacing/colour tokens plus
  `DraftModeUIButton`/`DraftModeUIPlatform` helpers for consistent iconography.
- Moved `DraftModeUIDialog` into `lib/components/dialog.dart` and kept the
  package exports aligned through `lib/components.dart` and `lib/pages.dart`.
- Added the `DraftModeUIPageExample` widget and bundled DraftMode branding
  assets for demos.
- Expanded the widget and unit test suite to cover the scaffolds, navigation
  items, icons, and documentation helpers.

## 1.0.0+1
- Renamed the public surface to the `DraftModeUIDialog` API to match the new `lib/ui.dart` export.
- Documented that localized strings now flow from the external `draftmode_localization` package instead of the old `lib/l10n` assets.
