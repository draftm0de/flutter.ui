import 'package:flutter/cupertino.dart';
import '../styles.dart';
import 'section.dart';

/// Displays a form row with an optional leading label and adaptive padding.
///
/// When [label] is provided the row renders a fixed-width leading column using
/// [DraftModeUIStyles.labelWidth] before expanding [child]. Padding follows the
/// shared spacing constants in [DraftModeUIStylePadding] so rows visually align
/// with native grouped lists and the label inherits [DraftModeUIStyleText].
/// Use [alignment] to fine-tune how [child] should sit within the content area
/// and provide custom [padding], [backgroundColor], or [height] overrides to
/// blend with bespoke grouped list treatments.
class DraftModeUIRow extends StatelessWidget {
  final Widget child;
  final String? label;
  final AlignmentGeometry alignment;
  final EdgeInsets? padding;
  final double? height;
  final Color? backgroundColor;

  const DraftModeUIRow(
    this.child, {
    super.key,
    this.label,
    this.alignment = Alignment.centerLeft,
    this.padding,
    this.backgroundColor,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasLabel = label?.trim().isNotEmpty ?? false;
    final Widget content = Align(alignment: alignment, child: child);

    final double effectiveLabelWidth =
        DraftModeUISectionScope.getLabelWidth(context) ??
            DraftModeUIStyles.labelWidth;

    final Widget body = hasLabel
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: effectiveLabelWidth,
                child: Text(label!, style: DraftModeUIStyleText.primary),
              ),
              Expanded(child: content),
            ],
          )
        : content;

    final EdgeInsets containerPadding = padding ??
        EdgeInsets.symmetric(
          horizontal: DraftModeUIStylePadding.primary,
          vertical: DraftModeUIStylePadding.tertiary,
        );

    if (backgroundColor != null || height != null) {
      return Container(
        height: height,
        color: backgroundColor,
        padding: containerPadding,
        child: body,
      );
    }

    return Padding(padding: containerPadding, child: body);
  }
}
