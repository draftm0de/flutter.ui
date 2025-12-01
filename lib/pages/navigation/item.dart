import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:draftmode_ui/components/badge.dart';
import 'package:draftmode_ui/platform.dart';

/// Shared navigation button used by top and bottom bars.
class DraftModePageNavigationItem extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final bool iconExpanded;
  final Color? iconColor;
  final Future<void> Function()? onTap;
  final Widget? loadWidget;
  final double? iconSize;
  final String? badge;

  const DraftModePageNavigationItem({
    super.key,
    this.text,
    this.icon,
    this.iconSize,
    this.iconExpanded = false,
    this.iconColor,
    this.badge,
    this.onTap,
    this.loadWidget,
  });

  Future<void> _onTap(BuildContext context) async {
    if (onTap != null) {
      await onTap!();
      return;
    }
    if (loadWidget != null) {
      await Navigator.of(context).push(
        DraftModeUIPlatform.isIOS
            ? CupertinoPageRoute(builder: (_) => loadWidget!)
            : MaterialPageRoute(builder: (_) => loadWidget!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    late final Widget child;
    if (icon != null && text?.isNotEmpty == true) {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        children: iconExpanded
            ? [
                Expanded(child: Text(text!)),
                Icon(icon, size: iconSize, color: iconColor),
              ]
            : [Icon(icon, size: iconSize, color: iconColor), Text(text!)],
      );
    } else if (icon != null) {
      child = Padding(
        padding: EdgeInsets.zero,
        child: Icon(icon, size: iconSize, color: iconColor),
      );
    } else if (text?.isNotEmpty == true) {
      child = Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Text(text!, style: TextStyle(color: iconColor)),
      );
    } else {
      child = const SizedBox();
    }

    final Widget display = (badge?.isNotEmpty == true)
        ? DraftModeUIBadged(
            badge: badge!,
            topOffset: -6,
            rightOffset: -8,
            child: child,
          )
        : child;

    return DraftModeUIPlatform.isIOS
        ? CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => _onTap(context),
            child: display,
          )
        : TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 10),
            ),
            onPressed: () => _onTap(context),
            child: display,
          );
  }
}
