import 'package:draftmode_ui/buttons.dart';
import 'package:draftmode_ui/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      home: Scaffold(body: child),
    );
  }

  testWidgets('renders placeholder row when no items are present',
      (tester) async {
    await tester.pumpWidget(
      wrap(
        const DraftModeUIList<DraftModeListItem>(
          items: <DraftModeListItem>[],
          emptyPlaceholder: Text('No items'),
          itemBuilder: _noopBuilder,
        ),
      ),
    );

    expect(find.text('No items'), findsOneWidget);
    expect(find.byType(DraftModeUIRow), findsOneWidget);
  });

  testWidgets('marks the selected item and triggers taps', (tester) async {
    final items = [
      const DraftModeListItem(id: 1, value: 'First'),
      const DraftModeListItem(id: 2, value: 'Second'),
    ];
    DraftModeListItem? tapped;

    await tester.pumpWidget(
      wrap(
        DraftModeUIList<DraftModeListItem>(
          items: items,
          selectedItem: items.first,
          onTap: (item) => tapped = item,
          itemBuilder: (item, isSelected) => Text('${item.value} $isSelected'),
        ),
      ),
    );

    expect(find.byIcon(DraftModeUIButton.checked), findsOneWidget);
    await tester.tap(find.text('Second false'));
    expect(tapped, items.last);
  });

  testWidgets('wraps the list in a refresh control when provided',
      (tester) async {
    await tester.pumpWidget(
      wrap(
        DraftModeUIList<DraftModeListItem>(
          items: const [DraftModeListItem(id: 1, value: 'Only')],
          onRefresh: () async {},
          itemBuilder: (item, _) => Text(item.value as String),
        ),
      ),
    );

    expect(find.byType(CustomScrollView), findsOneWidget);
    expect(find.byType(CupertinoSliverRefreshControl), findsOneWidget);
  });

  testWidgets('shows spinner row during pending state', (tester) async {
    await tester.pumpWidget(
      wrap(
        DraftModeUIList<DraftModeListItem>(
          isPending: true,
          items: const [DraftModeListItem(id: 1, value: 'Only')],
          itemBuilder: (item, _) => Text(item.value as String),
        ),
      ),
    );

    expect(find.byType(DraftModeUISpinner), findsOneWidget);
    expect(find.byType(CustomScrollView), findsNothing);
  });
}

Widget _noopBuilder(DraftModeListItem item, bool isSelected) =>
    const SizedBox.shrink();
