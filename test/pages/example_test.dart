import 'package:draftmode_ui/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
      'DraftModeUIPageExample uses DraftModeUIPage with header and injected children',
      (tester) async {
    const title = 'Demo gallery';
    const childLabel = 'Custom child';

    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    try {
      await tester.pumpWidget(
        const CupertinoApp(
          home: DraftModeUIPageExample(
            title: title,
            children: [Text(childLabel)],
          ),
        ),
      );

      expect(find.byType(DraftModeUIPage), findsOneWidget);
      expect(
          find.widgetWithText(CupertinoNavigationBar, title), findsOneWidget);
      expect(find.text('DraftMode'), findsOneWidget);
      expect(
        find.text('Development is infinite\n...like your mind'),
        findsOneWidget,
      );
      expect(find.text(childLabel), findsOneWidget);

      final finder = find.ancestor(
        of: find.text(childLabel),
        matching: find.byType(Padding),
      );
      expect(finder, findsWidgets);
      final Padding padding = tester.widget(finder.first);
      expect(padding.padding, EdgeInsets.zero);
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
  });

  testWidgets('DraftModeUIPageExample surfaces navigation overrides',
      (tester) async {
    const navTitle = 'Navigation override';
    const trailingItems = <DraftModePageNavigationTopItem>[
      DraftModePageNavigationTopItem(icon: CupertinoIcons.add),
    ];
    const bottomLeading = <DraftModePageNavigationBottomItem>[
      DraftModePageNavigationBottomItem(icon: CupertinoIcons.photo),
    ];
    const bottomCenter =
        DraftModePageNavigationBottomItem(icon: CupertinoIcons.play_arrow);
    const bottomTrailing = <DraftModePageNavigationBottomItem>[
      DraftModePageNavigationBottomItem(icon: CupertinoIcons.search),
    ];

    Future<bool> handleSave() async => true;

    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    try {
      await tester.pumpWidget(
        CupertinoApp(
          home: DraftModeUIPageExample(
            title: 'Fallback title',
            navigationTitle: navTitle,
            topLeadingText: 'Back',
            topTrailing: trailingItems,
            bottomLeading: bottomLeading,
            bottomCenter: bottomCenter,
            bottomTrailing: bottomTrailing,
            onSavePressed: handleSave,
            containerBackgroundColor: CupertinoColors.activeGreen,
            children: const [Text('Child')],
          ),
        ),
      );

      final DraftModeUIPage page = tester.widget(find.byType(DraftModeUIPage));
      expect(page.navigationTitle, navTitle);
      expect(page.topLeadingText, 'Back');
      expect(page.topTrailing, same(trailingItems));
      expect(page.bottomLeading, same(bottomLeading));
      expect(page.bottomCenter, same(bottomCenter));
      expect(page.bottomTrailing, same(bottomTrailing));
      expect(page.onSavePressed, same(handleSave));
      expect(page.containerBackgroundColor, CupertinoColors.activeGreen);

      expect(
        find.widgetWithText(CupertinoNavigationBar, navTitle),
        findsOneWidget,
      );
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
  });

  testWidgets('DraftModeUIPageExample disables default back affordance',
      (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    try {
      await tester.pumpWidget(
        const CupertinoApp(
          home: DraftModeUIPageExample(
            title: 'Demo gallery',
            children: [Text('Child')],
          ),
        ),
      );

      expect(find.byIcon(CupertinoIcons.back), findsNothing);

      final scaffoldFinder = find.byType(CupertinoPageScaffold);
      expect(scaffoldFinder, findsOneWidget);
      final CupertinoPageScaffold scaffold = tester.widget(scaffoldFinder);
      expect(
        scaffold.backgroundColor,
        equals(CupertinoColors.systemGroupedBackground),
      );
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
  });
}
