import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'platform.dart';

/// Convenience accessors for platform-aware icons.
class DraftModeUIButtons {
  static IconData get back =>
      DraftModeUIPlatform.isIOS ? CupertinoIcons.back : Icons.arrow_back;

  static IconData get close =>
      DraftModeUIPlatform.isIOS ? CupertinoIcons.clear : Icons.close;

  static IconData get cancel =>
      DraftModeUIPlatform.isIOS ? CupertinoIcons.multiply_circle : Icons.circle;

  static IconData get settings =>
      DraftModeUIPlatform.isIOS ? CupertinoIcons.settings : Icons.settings;

  static IconData get save =>
      DraftModeUIPlatform.isIOS ? CupertinoIcons.check_mark : Icons.check;

  static IconData get checked =>
      DraftModeUIPlatform.isIOS ? CupertinoIcons.check_mark : Icons.check;

  static IconData get checkSecondary =>
      DraftModeUIPlatform.isIOS ? CupertinoIcons.checkmark_alt : Icons.check;

  static IconData get logout => DraftModeUIPlatform.isIOS
      ? CupertinoIcons.square_arrow_right
      : Icons.logout;

  static IconData get start => DraftModeUIPlatform.isIOS
      ? CupertinoIcons.largecircle_fill_circle
      : Icons.mode_standby;

  static IconData get stop =>
      DraftModeUIPlatform.isIOS ? CupertinoIcons.stop_fill : Icons.stop;

  static IconData get edit => DraftModeUIPlatform.isIOS
      ? CupertinoIcons.square_pencil
      : Icons.edit_square;

  static IconData get plus =>
      DraftModeUIPlatform.isIOS ? CupertinoIcons.plus : Icons.plus_one_rounded;

  static IconData get arrowRight => DraftModeUIPlatform.isIOS
      ? CupertinoIcons.right_chevron
      : Icons.chevron_right;

  static IconData get arrowDown => DraftModeUIPlatform.isIOS
      ? CupertinoIcons.chevron_down
      : Icons.arrow_drop_down;

  static IconData get arrowLeft => DraftModeUIPlatform.isIOS
      ? CupertinoIcons.chevron_left
      : Icons.chevron_left;

  static IconData get arrowUp => DraftModeUIPlatform.isIOS
      ? CupertinoIcons.chevron_up
      : Icons.arrow_drop_up;

  static IconData get personCircle => DraftModeUIPlatform.isIOS
      ? CupertinoIcons.person_crop_circle
      : Icons.person;

  static IconData get eye =>
      DraftModeUIPlatform.isIOS ? CupertinoIcons.eye : Icons.visibility;

  static IconData get eyeSlash => DraftModeUIPlatform.isIOS
      ? CupertinoIcons.eye_slash
      : Icons.visibility_off;

  static IconData get trash =>
      DraftModeUIPlatform.isIOS ? CupertinoIcons.delete : Icons.delete;

  static IconData get listBullet => DraftModeUIPlatform.isIOS
      ? CupertinoIcons.list_bullet
      : Icons.format_list_bulleted;
}
