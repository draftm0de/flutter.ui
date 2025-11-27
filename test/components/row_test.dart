import 'package:draftmode_ui/components.dart';
import 'package:draftmode_ui/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget wrap(Widget child) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: MediaQuery(
        data: const MediaQueryData(),
        child: child,
      ),
    );
  }

  testWidgets('renders label column using shared tokens', (tester) async {
    await tester.pumpWidget(
      wrap(
        DraftModeUIRow(
          const Text('Value'),
          label: 'Email',
        ),
      ),
    );

    final SizedBox labelContainer =
        tester.widget<SizedBox>(find.byType(SizedBox));
    final Text labelText = tester.widget<Text>(find.text('Email'));

    expect(find.byType(Row), findsOneWidget);
    expect(labelContainer.width, DraftModeUIStyles.labelWidth);
    expect(labelText.style?.fontSize, DraftModeUIStyleFontSize.primary);
    expect(labelText.style?.color, DraftModeUIStyleColor.primary.text);
  });

  testWidgets('appends expanded widget with shared spacing', (tester) async {
    final expandedKey = UniqueKey();

    await tester.pumpWidget(
      wrap(
        DraftModeUIRow(
          const Text('Value'),
          label: 'Email',
          expanded: Icon(CupertinoIcons.check_mark, key: expandedKey),
        ),
      ),
    );

    final Finder rowFinder =
        find.ancestor(of: find.text('Value'), matching: find.byType(Row));
    final Row row = tester.widget<Row>(rowFinder.first);
    final Finder expandedFinder = find.byKey(expandedKey);
    final Finder paddedExpanded =
        find.ancestor(of: expandedFinder, matching: find.byType(Padding));
    final Padding padding = tester.widget<Padding>(paddedExpanded.first);
    final EdgeInsets resolvedPadding = padding.padding as EdgeInsets;

    expect(row.children.length, 3);
    expect(resolvedPadding.left, DraftModeUIStylePadding.tertiary);
  });

  testWidgets('omits label layout when label is blank', (tester) async {
    await tester.pumpWidget(
      wrap(
        DraftModeUIRow(
          const Text('Value'),
          label: '   ',
        ),
      ),
    );

    expect(find.byType(Row), findsNothing);
    expect(find.text('Value'), findsOneWidget);
  });

  testWidgets('still renders expanded widget when label missing',
      (tester) async {
    await tester.pumpWidget(
      wrap(
        DraftModeUIRow(
          const Text('Value'),
          expanded: CupertinoSwitch(value: false, onChanged: (_) {}),
        ),
      ),
    );

    expect(find.byType(Row), findsOneWidget);
    expect(find.byType(CupertinoSwitch), findsOneWidget);
  });

  testWidgets('wraps content in container when overrides provided',
      (tester) async {
    const padding = EdgeInsets.all(20);
    await tester.pumpWidget(
      wrap(
        DraftModeUIRow(
          const Text('Value'),
          backgroundColor: CupertinoColors.activeBlue,
          height: 48,
          padding: padding,
          alignment: Alignment.centerRight,
        ),
      ),
    );

    final Finder rowFinder = find.byType(DraftModeUIRow);
    final Finder containerFinder =
        find.descendant(of: rowFinder, matching: find.byType(Container));
    final Container container = tester.widget<Container>(containerFinder);
    final Align align = tester.widget<Align>(find.byType(Align));

    expect(containerFinder, findsOneWidget);
    expect(container.color, CupertinoColors.activeBlue);
    expect(container.padding, padding);
    expect(container.constraints?.maxHeight, 48);
    expect(container.constraints?.minHeight, 48);
    expect(align.alignment, Alignment.centerRight);
  });

  testWidgets('falls back to shared padding when not specified',
      (tester) async {
    await tester.pumpWidget(
      wrap(
        DraftModeUIRow(
          const Text('Value'),
          label: 'Name',
        ),
      ),
    );

    final Padding padding = tester.widget<Padding>(find.byType(Padding));

    expect(
      padding.padding,
      EdgeInsets.symmetric(
        horizontal: DraftModeUIStylePadding.primary,
        vertical: DraftModeUIStylePadding.tertiary,
      ),
    );
  });

  testWidgets('reads label width overrides from DraftModeUISection',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: DraftModeUISection(
          labelWidth: 140,
          children: [
            DraftModeUIRow(
              Text('Value'),
              label: 'Custom',
            ),
          ],
        ),
      ),
    );

    final sizedBoxFinder =
        find.ancestor(of: find.text('Custom'), matching: find.byType(SizedBox));
    final SizedBox labelContainer = tester.widget<SizedBox>(sizedBoxFinder);

    expect(labelContainer.width, 140);
  });
}
