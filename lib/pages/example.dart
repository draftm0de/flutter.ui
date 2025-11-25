import 'package:draftmode_ui/pages.dart';
import 'package:draftmode_ui/styles.dart';
import 'package:flutter/cupertino.dart';

/// Branded wrapper around [DraftModeUIPage] used throughout the example app.
///
/// The widget renders the DraftMode hero header while surfacing all navigation
/// slots so individual demos can inject custom trailing buttons, bottom bar
/// items, and save/back affordances without rebuilding the header from scratch.
class DraftModeUIPageExample extends StatelessWidget {
  /// Title displayed in the navigation bar when [navigationTitle] is omitted.
  final String title;

  /// Overrides the text rendered inside the navigation bar.
  final String? navigationTitle;

  /// Optional label rendered next to the platform back icon when the example
  /// is embedded in a navigation stack and the default leading control is used.
  final String? topLeadingText;

  /// Widgets displayed on the right side of the navigation bar.
  final List<DraftModePageNavigationTopItem>? topTrailing;

  /// Widgets anchored to the left side of the bottom bar.
  final List<DraftModePageNavigationBottomItem>? bottomLeading;

  /// Primary item centered in the bottom bar.
  final DraftModePageNavigationBottomItem? bottomCenter;

  /// Widgets anchored to the right side of the bottom bar.
  final List<DraftModePageNavigationBottomItem>? bottomTrailing;

  /// Content displayed under the DraftMode header card.
  final List<Widget> children;

  /// Optional callback invoked when the save action is triggered; returning
  /// `true` pops the page with a positive result.
  final Future<bool> Function()? onSavePressed;

  /// Overrides the default container/background colour.
  final Color? containerBackgroundColor;

  const DraftModeUIPageExample({
    super.key,
    required this.title,
    required this.children,
    this.navigationTitle,
    this.topLeadingText,
    this.topTrailing,
    this.bottomLeading,
    this.bottomCenter,
    this.bottomTrailing,
    this.onSavePressed,
    this.containerBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final String resolvedNavigationTitle = navigationTitle ?? title;

    return DraftModeUIPage(
        navigationTitle: resolvedNavigationTitle,
        topLeadingText: topLeadingText,
        topLeading: null,
        topTrailing: topTrailing,
        bottomLeading: bottomLeading,
        bottomCenter: bottomCenter,
        bottomTrailing: bottomTrailing,
        onSavePressed: onSavePressed,
        horizontalContainerPadding: 0,
        verticalContainerPadding: 0,
        containerBackgroundColor: containerBackgroundColor,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _HeaderCard(),
            SizedBox(height: DraftModeUIStylePadding.tertiary),
            ...children,
          ],
        ));
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: DraftModeUIStylePadding.primary),
      padding: EdgeInsets.all(DraftModeUIStylePadding.primary),
      decoration: BoxDecoration(
        border: Border.all(color: CupertinoColors.systemGrey, width: 0.8),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          // Include package name so the asset resolves when this widget ships as a dependency.
          Image.asset(
            'assets/images/logo.png',
            package: 'draftmode_ui',
            height: 70,
          ),
          SizedBox(width: DraftModeUIStylePadding.primary),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DraftMode',
                  style: TextStyle(
                      fontSize: DraftModeUIStyleFontSize.xLarge,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4),
                Text(
                  'Development is infinite\n...like your mind',
                  style:
                      TextStyle(fontSize: DraftModeUIStyleFontSize.secondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
