import 'package:draftmode_ui/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('DraftModeUIStylePadding exposes tokenized spacing', () {
    expect(DraftModeUIStylePadding.primary, 16);
    expect(DraftModeUIStylePadding.secondary, 14);
    expect(DraftModeUIStylePadding.tertiary, 10);
  });

  test('DraftModeUIStyleNavigationBar roles describe sizes', () {
    final top = DraftModeUIStyleNavigationBar.top;
    final bottom = DraftModeUIStyleNavigationBar.bottom;

    expect(top.containerHeight, 44);
    expect(top.iconHeight, 30);
    expect(bottom.containerHeight, 52);
    expect(bottom.iconHeight, 36);
  });

  test('DraftModeUIStyleColor roles contain Cupertino color pairs', () {
    final primary = DraftModeUIStyleColor.primary;
    final secondary = DraftModeUIStyleColor.secondary;
    final tertiary = DraftModeUIStyleColor.tertiary;

    expect(primary.background, CupertinoColors.systemBackground);
    expect(primary.text, CupertinoColors.label);
    expect(secondary.background, CupertinoColors.secondarySystemBackground);
    expect(secondary.text, CupertinoColors.secondaryLabel);
    expect(tertiary.background, CupertinoColors.systemGroupedBackground);
    expect(tertiary.text, CupertinoColors.secondaryLabel);
  });

  test('DraftModeUIStyleColorTint exposes accent palette', () {
    final primary = DraftModeUIStyleColorTint.primary;
    final secondary = DraftModeUIStyleColorTint.secondary;
    final tertiary = DraftModeUIStyleColorTint.tertiary;
    final quaternary = DraftModeUIStyleColorTint.quaternary;

    expect(primary.background, CupertinoColors.systemBlue);
    expect(secondary.background, CupertinoColors.systemRed);
    expect(tertiary.background, CupertinoColors.activeGreen);
    expect(quaternary.background, CupertinoColors.black);
  });

  test('DraftModeUIStyleText composes typography tokens', () {
    final primary = DraftModeUIStyleText.primary;
    final tertiary = DraftModeUIStyleText.tertiary;

    expect(primary.color, DraftModeUIStyleColor.primary.text);
    expect(primary.fontSize, DraftModeUIStyleFontSize.primary);
    expect(tertiary.fontSize, DraftModeUIStyleFontSize.tertiary);
  });

  test('DraftModeUIStyleButtonSizes encode dimensions', () {
    final large = DraftModeUIStyleButtonSizes.large;
    final medium = DraftModeUIStyleButtonSizes.medium;
    final small = DraftModeUIStyleButtonSizes.small;

    expect(large.height, 48);
    expect(medium.fontSize, 16);
    expect(small.height, 34);
  });

  test('DraftModeUIStyleButtonColors provide fallbacks', () {
    final submit = DraftModeUIStyleButtonColors.submit;
    final dateTime = DraftModeUIStyleButtonColors.dateTime;
    final inline = DraftModeUIStyleButtonColors.inline;

    expect(submit.background, DraftModeUIStyleColorTint.primary.background);
    expect(dateTime.background, CupertinoColors.systemGrey5);
    expect(inline.font, DraftModeUIStyleColorTint.primary.background);
  });

  test('DraftModeUIStyleIconSize + font sizes remain consistent', () {
    expect(DraftModeUIStyleIconSize.large, 22);
    expect(DraftModeUIStyleIconSize.medium, 18);
    expect(DraftModeUIStyleIconSize.small, 16);
    expect(DraftModeUIStyleFontSize.secondary, 15);
  });

  test('DraftModeUIStyles exposes row label width token', () {
    expect(DraftModeUIStyles.labelWidth, 100);
  });
}
