# draftmode_ui_example

Reference host app that previews DraftMode UI components. The example wires the
page scaffolding, grouped sections, and labelled rows together so you can see
how the design tokens behave in a full layout. Screens reuse the
`DraftModeUIPageExample` wrapper so individual demos can swap navigation bar
buttons, bottom bar icons, and save callbacks without duplicating scaffold code.

## Running locally

```
flutter pub get
flutter run
```

`main.dart` overrides `DraftModeUIStyles.labelWidth` to demonstrate the global
configuration path while `HomeScreen` shows multiple `DraftModeUISection`
instances with different header + label combinations.
