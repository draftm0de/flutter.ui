import 'package:flutter/cupertino.dart';
import 'package:draftmode_ui/styles.dart';
import 'section.dart';

/// Displays a form row with an optional leading label and adaptive padding.
///
/// When [label] is provided the row renders a fixed-width leading column using
/// [DraftModeUIStyles.labelWidth] before expanding [child]. Padding follows the
/// shared spacing constants in [DraftModeUIStylePadding] so rows visually align
/// with native grouped lists and the label inherits [DraftModeUIStyleText].
/// Use [alignment] to fine-tune how [child] should sit within the content area
/// and provide custom [padding], [backgroundColor], or [height] overrides to
/// blend with bespoke grouped list treatments. Provide [expanded] to append a
/// trailing widget (badges, toggles, inline buttons) offset with the shared
/// tertiary padding token.
class DraftModeUIRow extends StatelessWidget {
  final Widget child;
  final String? label;
  final AlignmentGeometry alignment;
  final EdgeInsets? padding;
  final double? height;
  final Color? backgroundColor;

  /// Optional trailing widget displayed after the main [child]. Useful for
  /// status badges or quick actions that shouldn't consume the core content
  /// width.
  final Widget? expanded;

  const DraftModeUIRow(
    this.child, {
    super.key,
    this.label,
    this.alignment = Alignment.centerLeft,
    this.padding,
    this.backgroundColor,
    this.height,
    this.expanded,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasLabel = label?.trim().isNotEmpty ?? false;
    final bool hasExpanded = expanded != null;
    final Widget content = Align(alignment: alignment, child: child);

    final double effectiveLabelWidth =
        DraftModeUISectionScope.getLabelWidth(context) ??
            DraftModeUIStyles.labelWidth;

    final List<Widget> children = [];
    if (hasLabel) {
      children.add(SizedBox(
        width: effectiveLabelWidth,
        child: Text(label!, style: DraftModeUIStyleText.primary),
      ));
    }
    children.add(Expanded(child: content));
    if (hasExpanded) {
      children.add(
        Padding(
          padding: EdgeInsets.only(left: DraftModeUIStylePadding.tertiary),
          child: expanded,
        ),
      );
    }

    Widget body;
    if (children.length > 1) {
      body = Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: children.toList(),
      );
    } else {
      body = content;
    }

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
