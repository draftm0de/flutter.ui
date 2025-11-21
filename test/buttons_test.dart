import 'package:draftmode_ui/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('DraftModeUIButton resolves to Cupertino icons on iOS', () {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    try {
      expect(DraftModeUIButtons.back, CupertinoIcons.back);
      expect(DraftModeUIButtons.close, CupertinoIcons.clear);
      expect(DraftModeUIButtons.cancel, CupertinoIcons.multiply_circle);
      expect(DraftModeUIButtons.settings, CupertinoIcons.settings);
      expect(DraftModeUIButtons.save, CupertinoIcons.check_mark);
      expect(DraftModeUIButtons.checked, CupertinoIcons.check_mark);
      expect(DraftModeUIButtons.checkSecondary, CupertinoIcons.checkmark_alt);
      expect(DraftModeUIButtons.logout, CupertinoIcons.square_arrow_right);
      expect(DraftModeUIButtons.start, CupertinoIcons.largecircle_fill_circle);
      expect(DraftModeUIButtons.stop, CupertinoIcons.stop_fill);
      expect(DraftModeUIButtons.edit, CupertinoIcons.square_pencil);
      expect(DraftModeUIButtons.plus, CupertinoIcons.plus);
      expect(DraftModeUIButtons.arrowRight, CupertinoIcons.right_chevron);
      expect(DraftModeUIButtons.arrowDown, CupertinoIcons.chevron_down);
      expect(DraftModeUIButtons.arrowLeft, CupertinoIcons.chevron_left);
      expect(DraftModeUIButtons.arrowUp, CupertinoIcons.chevron_up);
      expect(
          DraftModeUIButtons.personCircle, CupertinoIcons.person_crop_circle);
      expect(DraftModeUIButtons.eye, CupertinoIcons.eye);
      expect(DraftModeUIButtons.eyeSlash, CupertinoIcons.eye_slash);
      expect(DraftModeUIButtons.trash, CupertinoIcons.delete);
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
  });

  test('DraftModeUIButton resolves to Material icons on Android', () {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    try {
      expect(DraftModeUIButtons.back, Icons.arrow_back);
      expect(DraftModeUIButtons.close, Icons.close);
      expect(DraftModeUIButtons.cancel, Icons.circle);
      expect(DraftModeUIButtons.settings, Icons.settings);
      expect(DraftModeUIButtons.save, Icons.check);
      expect(DraftModeUIButtons.checked, Icons.check);
      expect(DraftModeUIButtons.checkSecondary, Icons.check);
      expect(DraftModeUIButtons.logout, Icons.logout);
      expect(DraftModeUIButtons.start, Icons.mode_standby);
      expect(DraftModeUIButtons.stop, Icons.stop);
      expect(DraftModeUIButtons.edit, Icons.edit_square);
      expect(DraftModeUIButtons.plus, Icons.plus_one_rounded);
      expect(DraftModeUIButtons.arrowRight, Icons.chevron_right);
      expect(DraftModeUIButtons.arrowDown, Icons.arrow_drop_down);
      expect(DraftModeUIButtons.arrowLeft, Icons.chevron_left);
      expect(DraftModeUIButtons.arrowUp, Icons.arrow_drop_up);
      expect(DraftModeUIButtons.personCircle, Icons.person);
      expect(DraftModeUIButtons.eye, Icons.visibility);
      expect(DraftModeUIButtons.eyeSlash, Icons.visibility_off);
      expect(DraftModeUIButtons.trash, Icons.delete);
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
  });
}
