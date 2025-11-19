import 'package:draftmode_ui/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Cupertino navigation item pushes loadWidget when tapped',
      (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    try {
      await tester.pumpWidget(
        const CupertinoApp(
          home: DraftModePageNavigationItem(
            text: 'Open',
            icon: CupertinoIcons.add,
            loadWidget: _DummyDestination(),
          ),
        ),
      );

      expect(find.byType(CupertinoButton), findsOneWidget);

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.byType(_DummyDestination), findsOneWidget);
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
  });

  testWidgets('Material navigation item triggers callback and variants',
      (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    bool tapped = false;

    try {
      await tester.pumpWidget(
        MaterialApp(
          home: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DraftModePageNavigationItem(
                text: 'Callback',
                icon: Icons.play_arrow,
                iconExpanded: true,
                iconColor: Colors.red,
                onTap: () async {
                  tapped = true;
                },
              ),
              const DraftModePageNavigationItem(
                text: 'Text only',
                iconColor: Colors.green,
              ),
              const DraftModePageNavigationItem(
                icon: Icons.settings,
                iconColor: Colors.blue,
              ),
              const DraftModePageNavigationItem(),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Callback'));
      await tester.pump();

      expect(tapped, isTrue);
      expect(find.byType(TextButton), findsNWidgets(4));
      expect(find.byType(Expanded), findsOneWidget);

      final Text textOnly = tester.widget(find.text('Text only'));
      expect(textOnly.style?.color, Colors.green);

      final Icon iconOnly = tester.widget(find.byIcon(Icons.settings));
      expect(iconOnly.color, Colors.blue);
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
  });

  testWidgets('Material navigation item pushes loadWidget route when tapped',
      (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;

    try {
      await tester.pumpWidget(
        const MaterialApp(
          home: DraftModePageNavigationItem(
            text: 'Load',
            loadWidget: _DummyDestination(),
          ),
        ),
      );

      await tester.tap(find.text('Load'));
      await tester.pumpAndSettle();

      expect(find.byType(_DummyDestination), findsOneWidget);
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
  });
}

class _DummyDestination extends StatelessWidget {
  const _DummyDestination();

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Center(child: Text('Loaded destination')),
    );
  }
}
