import 'dart:async';

import 'package:draftmode_ui/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('DraftModeUIPage', () {
    testWidgets('renders Cupertino scaffolding with default nav controls',
        (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      try {
        await tester.pumpWidget(
          CupertinoApp(
            home: DraftModeUIPage(
              navigationTitle: 'Docs',
              topLeadingText: 'Back',
              onSavePressed: () async => false,
              body: const Text('Content'),
              bottomLeading: const [
                DraftModePageNavigationBottomItem(
                  text: 'Left',
                  icon: CupertinoIcons.arrow_left_circle,
                ),
                DraftModePageNavigationBottomItem(
                  text: 'Second',
                  icon: CupertinoIcons.square_list,
                ),
              ],
              bottomTrailing: const [
                DraftModePageNavigationBottomItem(
                  text: 'Right',
                  icon: CupertinoIcons.arrow_right_circle,
                ),
              ],
              bottomCenter: const DraftModePageNavigationBottomItem(
                icon: CupertinoIcons.waveform,
              ),
            ),
          ),
        );

        expect(find.byType(CupertinoPageScaffold), findsOneWidget);
        expect(find.byType(DraftModePageNavigationBottom), findsOneWidget);
        expect(
          find.widgetWithText(CupertinoNavigationBar, 'Docs'),
          findsOneWidget,
        );
        expect(find.text('Back'), findsOneWidget);
        expect(find.byIcon(CupertinoIcons.check_mark), findsOneWidget);

        final Padding padding = tester.widget<Padding>(
          find
              .ancestor(
                of: find.text('Content'),
                matching: find.byType(Padding),
              )
              .first,
        );

        expect(
          padding.padding,
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        );
      } finally {
        debugDefaultTargetPlatformOverride = null;
      }
    });

    testWidgets('save button pops route when callback returns true',
        (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      try {
        final navigatorKey = GlobalKey<NavigatorState>();
        bool saveInvoked = false;

        await tester.pumpWidget(
          MaterialApp(
            navigatorKey: navigatorKey,
            home: const SizedBox.shrink(),
          ),
        );

        unawaited(
          navigatorKey.currentState!.push(
            MaterialPageRoute(
              builder: (_) => DraftModeUIPage(
                navigationTitle: 'Edit',
                topLeadingText: 'Close',
                body: const Text('Body'),
                onSavePressed: () async {
                  saveInvoked = true;
                  return true;
                },
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(navigatorKey.currentState!.canPop(), isTrue);
        expect(find.byIcon(Icons.check), findsOneWidget);

        await tester.tap(find.byIcon(Icons.check));
        await tester.pumpAndSettle();

        expect(saveInvoked, isTrue);
        expect(navigatorKey.currentState!.canPop(), isFalse);
      } finally {
        debugDefaultTargetPlatformOverride = null;
      }
    });

    testWidgets('honors explicit padding and background overrides',
        (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      try {
        const background = Color(0xFF112233);

        await tester.pumpWidget(
          MaterialApp(
            home: DraftModeUIPage(
              containerBackgroundColor: background,
              horizontalContainerPadding: 8,
              verticalContainerPadding: 4,
              body: const Text('Custom padding'),
            ),
          ),
        );

        final Padding padding = tester.widget<Padding>(
          find
              .ancestor(
                of: find.text('Custom padding'),
                matching: find.byType(Padding),
              )
              .first,
        );

        expect(
          padding.padding,
          const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        );

        final Scaffold scaffold = tester.widget(find.byType(Scaffold));
        expect(scaffold.backgroundColor, background);
      } finally {
        debugDefaultTargetPlatformOverride = null;
      }
    });

    testWidgets('respects injected navigation widgets when provided',
        (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      try {
        final bottomLeadingItems = [
          DraftModePageNavigationBottomItem(icon: Icons.home),
        ];
        final bottomTrailingItems = [
          DraftModePageNavigationBottomItem(icon: Icons.settings),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: DraftModeUIPage(
              navigationTitle: 'Custom',
              topLeading: const Icon(Icons.menu),
              topTrailing: const [
                DraftModePageNavigationTopItem(icon: Icons.search),
              ],
              bottomLeading: bottomLeadingItems,
              bottomCenter: DraftModePageNavigationBottomItem(
                icon: Icons.play_arrow,
              ),
              bottomTrailing: bottomTrailingItems,
              body: const Text('Body'),
            ),
          ),
        );

        expect(find.byIcon(Icons.menu), findsOneWidget);
        expect(find.byIcon(Icons.search), findsOneWidget);
        expect(find.byIcon(Icons.play_arrow), findsOneWidget);
        expect(find.byIcon(Icons.settings), findsOneWidget);
      } finally {
        debugDefaultTargetPlatformOverride = null;
      }
    });

    testWidgets('shows a badge when badge set', (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      try {
        await tester.pumpWidget(
          const MaterialApp(
            home: DraftModeUIPage(
              body: SizedBox.shrink(),
              bottomCenter: DraftModePageNavigationBottomItem(
                icon: Icons.mail_outline,
                badge: '7',
              ),
            ),
          ),
        );

        expect(find.text('7'), findsOneWidget);
      } finally {
        debugDefaultTargetPlatformOverride = null;
      }
    });

    testWidgets('renders custom badge strings', (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      try {
        await tester.pumpWidget(
          const MaterialApp(
            home: DraftModeUIPage(
              body: SizedBox.shrink(),
              bottomCenter: DraftModePageNavigationBottomItem(
                icon: Icons.mail_outline,
                badge: '99+',
              ),
            ),
          ),
        );

        expect(find.text('99+'), findsOneWidget);
      } finally {
        debugDefaultTargetPlatformOverride = null;
      }
    });
  });
}
