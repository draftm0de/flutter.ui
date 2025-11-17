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
      expect(DraftModeUIButton.back, CupertinoIcons.back);
      expect(DraftModeUIButton.close, CupertinoIcons.clear);
      expect(DraftModeUIButton.cancel, CupertinoIcons.multiply_circle);
      expect(DraftModeUIButton.settings, CupertinoIcons.settings);
      expect(DraftModeUIButton.save, CupertinoIcons.check_mark);
      expect(DraftModeUIButton.checked, CupertinoIcons.check_mark);
      expect(DraftModeUIButton.checkSecondary, CupertinoIcons.checkmark_alt);
      expect(DraftModeUIButton.logout, CupertinoIcons.square_arrow_right);
      expect(DraftModeUIButton.start, CupertinoIcons.largecircle_fill_circle);
      expect(DraftModeUIButton.stop, CupertinoIcons.stop_fill);
      expect(DraftModeUIButton.edit, CupertinoIcons.square_pencil);
      expect(DraftModeUIButton.plus, CupertinoIcons.plus);
      expect(DraftModeUIButton.arrowRight, CupertinoIcons.right_chevron);
      expect(DraftModeUIButton.arrowDown, CupertinoIcons.chevron_down);
      expect(DraftModeUIButton.arrowLeft, CupertinoIcons.chevron_left);
      expect(DraftModeUIButton.arrowUp, CupertinoIcons.chevron_up);
      expect(DraftModeUIButton.personCircle, CupertinoIcons.person_crop_circle);
      expect(DraftModeUIButton.eye, CupertinoIcons.eye);
      expect(DraftModeUIButton.eyeSlash, CupertinoIcons.eye_slash);
      expect(DraftModeUIButton.trash, CupertinoIcons.delete);
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
  });

  test('DraftModeUIButton resolves to Material icons on Android', () {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    try {
      expect(DraftModeUIButton.back, Icons.arrow_back);
      expect(DraftModeUIButton.close, Icons.close);
      expect(DraftModeUIButton.cancel, Icons.circle);
      expect(DraftModeUIButton.settings, Icons.settings);
      expect(DraftModeUIButton.save, Icons.check);
      expect(DraftModeUIButton.checked, Icons.check);
      expect(DraftModeUIButton.checkSecondary, Icons.check);
      expect(DraftModeUIButton.logout, Icons.logout);
      expect(DraftModeUIButton.start, Icons.mode_standby);
      expect(DraftModeUIButton.stop, Icons.stop);
      expect(DraftModeUIButton.edit, Icons.edit_square);
      expect(DraftModeUIButton.plus, Icons.plus_one_rounded);
      expect(DraftModeUIButton.arrowRight, Icons.chevron_right);
      expect(DraftModeUIButton.arrowDown, Icons.arrow_drop_down);
      expect(DraftModeUIButton.arrowLeft, Icons.chevron_left);
      expect(DraftModeUIButton.arrowUp, Icons.arrow_drop_up);
      expect(DraftModeUIButton.personCircle, Icons.person);
      expect(DraftModeUIButton.eye, Icons.visibility);
      expect(DraftModeUIButton.eyeSlash, Icons.visibility_off);
      expect(DraftModeUIButton.trash, Icons.delete);
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
  });
}
