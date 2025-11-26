import 'package:draftmode_ui/platform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as material;

/// Adaptive switch that mirrors the native control for the active platform.
///
/// Uses [CupertinoSwitch] on iOS and [Switch.adaptive] elsewhere so behaviour
/// (haptics, motion, styling) matches user expectations.
class DraftModeUISwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  const DraftModeUISwitch({
    super.key,
    this.value = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (DraftModeUIPlatform.isIOS) {
      return CupertinoSwitch(value: value, onChanged: onChanged);
    }
    return material.Switch.adaptive(value: value, onChanged: onChanged);
  }
}
