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
