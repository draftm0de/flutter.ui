import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:draftmode_ui/platform.dart';
import 'package:draftmode_ui/styles.dart';

/// Groups related form rows into a platform-adaptive container.
///
/// On iOS this uses [CupertinoListSection.insetGrouped]; on other platforms it
/// wraps content in a `Card`. Provide [labelWidth] to override
/// [DraftModeUIStyles.labelWidth] just for this section and auto-align nested
/// [DraftModeUIRow] widgets. The [transparent] flag disables the Cupertino
/// background decoration for sections that should visually blend with their
/// parents.
class DraftModeUISection extends StatelessWidget {
  final String? header;
  final List<Widget> children;
  final bool transparent;
  final double? labelWidth;

  const DraftModeUISection(
      {super.key,
      this.header,
      required this.children,
      this.transparent = false,
      this.labelWidth});

  @override
  Widget build(BuildContext context) {
    final bool hasHeader = header != null;

    return DraftModeUISectionScope(
      labelWidth: labelWidth,
      child: DraftModeUIPlatform.isIOS
          ? CupertinoListSection.insetGrouped(
              additionalDividerMargin: 0,
              margin: EdgeInsets.symmetric(
                horizontal: DraftModeUIStylePadding.primary,
              ),
              decoration: transparent ? BoxDecoration(color: null) : null,
              header: hasHeader
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: DraftModeUIStylePadding.tertiary,
                      ),
                      child: Text(header ?? ''),
                    )
                  : null,
              children: children,
            )
          : Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (hasHeader)
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: DraftModeUIStylePadding.primary,
                          top: DraftModeUIStylePadding.primary,
                          left: DraftModeUIStylePadding.tertiary,
                        ),
                        child: Text(header ?? ''),
                      ),
                    ...children,
                  ],
                ),
              ),
            ),
    );
  }
}

/// Exposes contextual hints for descendants rendered within a [DraftModeUISection].
///
/// Widgets can call [isInSection] to adjust layout, read [getLabelWidth] to stay
/// in sync with surrounding rows, or use [containerPadding] for consistent
/// horizontal padding when emulating section spacing.
class DraftModeUISectionScope extends InheritedWidget {
  final double? labelWidth;

  const DraftModeUISectionScope({
    super.key,
    required super.child,
    this.labelWidth,
  });

  static bool isInSection(BuildContext context) {
    return context
            .dependOnInheritedWidgetOfExactType<DraftModeUISectionScope>() !=
        null;
  }

  static double? getLabelWidth(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<DraftModeUISectionScope>()
        ?.labelWidth;
  }

  static EdgeInsetsGeometry get containerPadding =>
      const EdgeInsets.symmetric(horizontal: 20);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
