import 'package:flutter/cupertino.dart';
import 'package:draftmode_ui/styles.dart';

/// Pill-shaped badge used to surface counts or short labels.
class DraftModeUIBadge extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final EdgeInsets padding;
  final double minSize;
  final double borderRadius;

  DraftModeUIBadge({
    super.key,
    required this.label,
    Color? backgroundColor,
    Color? textColor,
    EdgeInsets? padding,
    double? minSize,
    double? borderRadius,
  })  : backgroundColor =
            backgroundColor ?? DraftModeUIStyleColorTint.secondary.background,
        textColor = textColor ?? DraftModeUIStyleColorTint.secondary.text,
        padding =
            padding ?? const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        minSize = minSize ?? 18,
        borderRadius = borderRadius ?? 9;

  /// Formats [count] as a badge string while capping overflow; returns `null`
  /// when the count is absent or zero so callers can skip rendering.
  static String? formatCountOrNull(int? count,
      {int cap = 99, String overflowLabel = '99+'}) {
    if (count == null || count <= 0) {
      return null;
    }
    if (count > cap) {
      return overflowLabel;
    }
    return count.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: minSize, minHeight: minSize),
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor,
          fontSize: DraftModeUIStyleFontSize.tertiary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// Wraps [child] with a positioned [DraftModeUIBadge] when [badge] is provided.
class DraftModeUIBadged extends StatelessWidget {
  final Widget child;
  final String? badge;
  final double topOffset;
  final double rightOffset;

  const DraftModeUIBadged({
    super.key,
    required this.child,
    this.badge,
    this.topOffset = -6,
    this.rightOffset = -8,
  });

  @override
  Widget build(BuildContext context) {
    if (badge?.isNotEmpty != true) {
      return child;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: topOffset,
          right: rightOffset,
          child: DraftModeUIBadge(label: badge!),
        ),
      ],
    );
  }
}
