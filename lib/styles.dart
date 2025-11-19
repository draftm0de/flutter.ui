import 'package:flutter/cupertino.dart';

class DraftModeUIStylePadding {
  static double get primary => 16;
  static double get secondary => 14;
  static double get tertiary => 10;
}

class DraftModeUIStyleNavigationBarRole {
  final double containerHeight;
  final double iconHeight;
  const DraftModeUIStyleNavigationBarRole({
    required this.containerHeight,
    required this.iconHeight,
  });
}

class DraftModeUIStyleNavigationBar {
  static DraftModeUIStyleNavigationBarRole get top =>
      DraftModeUIStyleNavigationBarRole(
          containerHeight: 44.0, iconHeight: 30.0);
  static DraftModeUIStyleNavigationBarRole get bottom =>
      DraftModeUIStyleNavigationBarRole(
          containerHeight: 52.0, iconHeight: 36.0);
}

class DraftModeUIStyleColorRole {
  final Color background;
  final Color text;
  const DraftModeUIStyleColorRole(
      {required this.background, required this.text});
}

class DraftModeUIStyleColor {
  static DraftModeUIStyleColorRole get primary =>
      const DraftModeUIStyleColorRole(
        background: CupertinoColors.systemBackground,
        text: CupertinoColors.label,
      );
  static DraftModeUIStyleColorRole get secondary =>
      const DraftModeUIStyleColorRole(
        background: CupertinoColors.secondarySystemBackground,
        text: CupertinoColors.secondaryLabel,
      );
  static DraftModeUIStyleColorRole get tertiary =>
      const DraftModeUIStyleColorRole(
        background: CupertinoColors.systemGroupedBackground,
        text: CupertinoColors.secondaryLabel,
      );
}

/// Canonical text styles used across DraftMode UI widgets.
class DraftModeUIStyleText {
  static TextStyle get primary => TextStyle(
        color: DraftModeUIStyleColor.primary.text,
        fontSize: DraftModeUIStyleFontSize.primary,
      );
  static TextStyle get tertiary => TextStyle(
        color: DraftModeUIStyleColor.primary.text,
        fontSize: DraftModeUIStyleFontSize.tertiary,
      );
}

/// Icon sizing tokens to keep glyph sizes consistent.
class DraftModeUIStyleIconSize {
  static double get large => 22;
  static double get medium => 18;
  static double get small => 16;
}

/// Font sizing tokens for the shared text styles.
class DraftModeUIStyleFontSize {
  static double get primary => 17;
  static double get secondary => 15;
  static double get tertiary => 12;
}

/// Miscellaneous UI style helpers that do not fit other buckets.
class DraftModeUIStyles {
  static double labelWidth = 100;
}
