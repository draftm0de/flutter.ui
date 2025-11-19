import 'package:draftmode_ui/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('renders inset grouped list on iOS', (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

    await tester.pumpWidget(
      const CupertinoApp(
        home: DraftModeUISection(
          header: 'Section header',
          transparent: true,
          children: [
            DraftModeUIRow(Text('Value'), label: 'Name'),
          ],
        ),
      ),
    );

    expect(find.byType(CupertinoListSection), findsOneWidget);
    expect(find.text('Section header'), findsOneWidget);

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('renders Material card when not on iOS', (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;

    await tester.pumpWidget(
      const MaterialApp(
        home: DraftModeUISection(
          header: 'Material header',
          children: [
            DraftModeUIRow(Text('Value')),
          ],
        ),
      ),
    );

    expect(find.byType(Card), findsOneWidget);
    expect(find.byType(CupertinoListSection), findsNothing);
    expect(find.text('Material header'), findsOneWidget);

    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('exposes inherited label width via DraftModeUISectionScope',
      (tester) async {
    bool? isInSection;
    double? inheritedWidth;

    await tester.pumpWidget(
      MaterialApp(
        home: DraftModeUISection(
          labelWidth: 180,
          children: [
            Builder(
              builder: (context) {
                isInSection = DraftModeUISectionScope.isInSection(context);
                inheritedWidth = DraftModeUISectionScope.getLabelWidth(context);
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );

    expect(isInSection, isTrue);
    expect(inheritedWidth, 180);
    expect(
      DraftModeUISectionScope.containerPadding,
      const EdgeInsets.symmetric(horizontal: 20),
    );
  });
}
