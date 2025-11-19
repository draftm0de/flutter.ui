import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'item.dart';
import 'package:draftmode_ui/styles.dart';

/// Convenience wrapper configuring a [DraftModePageNavigationItem] for the top bar.
class DraftModePageNavigationTopItem extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final bool iconExpanded;
  final Color? iconColor;
  final double? iconHeight;
  final Future<void> Function()? onTap;
  final Widget? loadWidget;

  const DraftModePageNavigationTopItem({
    super.key,
    this.text,
    this.icon,
    this.iconExpanded = false,
    this.iconColor,
    this.iconHeight,
    this.onTap,
    this.loadWidget,
  });

  @override
  Widget build(BuildContext context) {
    final double useIconHeight =
        iconHeight ?? DraftModeUIStyleNavigationBar.top.iconHeight;
    return DraftModePageNavigationItem(
      text: text,
      icon: icon,
      iconSize: useIconHeight,
      iconExpanded: iconExpanded,
      iconColor: iconColor,
      onTap: onTap,
      loadWidget: loadWidget,
    );
  }
}
