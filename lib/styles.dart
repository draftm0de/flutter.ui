import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

class DraftModeUIStyleColorTint {
  static DraftModeUIStyleColorRole get primary =>
      const DraftModeUIStyleColorRole(
        background: CupertinoColors.systemBlue,
        text: CupertinoColors.white,
      );
  static DraftModeUIStyleColorRole get secondary =>
      const DraftModeUIStyleColorRole(
        background: CupertinoColors.systemRed,
        text: CupertinoColors.white,
      );
  static DraftModeUIStyleColorRole get tertiary =>
      const DraftModeUIStyleColorRole(
        background: CupertinoColors.activeGreen,
        text: CupertinoColors.black,
      );
  static DraftModeUIStyleColorRole get quaternary =>
      const DraftModeUIStyleColorRole(
        background: CupertinoColors.black,
        text: CupertinoColors.white,
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

class DraftModeUIStyleButtonSize {
  final double height;
  final double fontSize;
  final FontWeight fontWeight;
  const DraftModeUIStyleButtonSize({
    required this.height,
    required this.fontSize,
    required this.fontWeight,
  });
}

class DraftModeUIStyleButtonSizes {
  static DraftModeUIStyleButtonSize get large =>
      const DraftModeUIStyleButtonSize(
        height: 48,
        fontSize: 18,
        fontWeight: FontWeight.normal,
      );

  static DraftModeUIStyleButtonSize get medium =>
      const DraftModeUIStyleButtonSize(
        height: 40,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      );

  static DraftModeUIStyleButtonSize get small =>
      const DraftModeUIStyleButtonSize(
        height: 34,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      );
}

class DraftModeUIStyleButtonColor {
  final Color? background;
  final Color font;
  const DraftModeUIStyleButtonColor({this.background, required this.font});
}

class DraftModeUIStyleButtonColors {
  static DraftModeUIStyleButtonColor get submit => DraftModeUIStyleButtonColor(
        background: DraftModeUIStyleColorTint.primary.background,
        font: DraftModeUIStyleColorTint.primary.text,
      );
  static DraftModeUIStyleButtonColor get dateTime =>
      DraftModeUIStyleButtonColor(
        background: CupertinoColors.systemGrey5,
        font: Colors.black,
      );
  static DraftModeUIStyleButtonColor get inline => DraftModeUIStyleButtonColor(
        font: DraftModeUIStyleColorTint.primary.background,
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
  static double get xLarge => 20;
}

/// Miscellaneous UI style helpers that do not fit other buckets.
class DraftModeUIStyles {
  static double labelWidth = 100;
}
