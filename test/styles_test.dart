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
}
