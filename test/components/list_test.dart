import 'package:draftmode_ui/buttons.dart';
import 'package:draftmode_ui/components.dart';
import 'package:draftmode_ui/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      home: Scaffold(body: child),
    );
  }

  test('DraftModeListItemBuilder maps entries into immutable list', () {
    final source = {'a': 'Alpha', 'b': 'Beta'};

    final items = DraftModeListItemBuilder.fromMap(source);

    expect(items.length, 2);
    expect(items.first.id, 'a');
    expect(items.first.value, 'Alpha');
    expect(items.last.id, 'b');
    expect(items.last.value, 'Beta');
  });

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

    expect(find.byIcon(DraftModeUIButtons.checked), findsOneWidget);
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

  testWidgets('applies padding to refreshed list sliver', (tester) async {
    await tester.pumpWidget(
      wrap(
        DraftModeUIList<DraftModeListItem>(
          items: const [DraftModeListItem(id: 1, value: 'Only')],
          onRefresh: () async {},
          padding: const EdgeInsets.all(12),
          itemBuilder: (item, _) => Text(item.value as String),
        ),
      ),
    );

    expect(find.byType(SliverPadding), findsOneWidget);
  });

  testWidgets('renders header and separator when provided', (tester) async {
    const header = DraftModeUIRow(Text('Header'));
    const separator = SizedBox(height: 4);

    await tester.pumpWidget(
      wrap(
        DraftModeUIList<DraftModeListItem>(
          items: const [
            DraftModeListItem(id: 1, value: 'Only'),
            DraftModeListItem(id: 2, value: 'Second'),
          ],
          header: header,
          separator: separator,
          itemBuilder: (item, _) => Text(item.value as String),
        ),
      ),
    );

    expect(find.byWidget(header), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.height == 4,
      ),
      findsWidgets,
    );
    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('renders header when separator parameter omitted',
      (tester) async {
    await tester.pumpWidget(
      wrap(
        DraftModeUIList<DraftModeListItem>(
          header: const DraftModeUIRow(Text('Header only')),
          items: const [
            DraftModeListItem(id: 1, value: 'Only'),
            DraftModeListItem(id: 2, value: 'Second'),
          ],
          itemBuilder: (item, _) => Text(item.value as String),
        ),
      ),
    );

    expect(find.text('Header only'), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) {
          if (widget is Container) {
            return widget.color == CupertinoColors.separator;
          }
          return false;
        },
      ),
      findsWidgets,
    );
  });

  testWidgets('applies default separator styling when not provided',
      (tester) async {
    await tester.pumpWidget(
      wrap(
        DraftModeUIList<DraftModeListItem>(
          items: const [
            DraftModeListItem(id: 1, value: 'Only'),
            DraftModeListItem(id: 2, value: 'Second'),
          ],
          itemBuilder: (item, _) => Text(item.value as String),
        ),
      ),
    );

    final separatorFinder = find.byWidgetPredicate(
      (widget) {
        if (widget is Container) {
          return widget.color == CupertinoColors.separator &&
              widget.margin ==
                  EdgeInsets.symmetric(
                      horizontal: DraftModeUIStylePadding.primary);
        }
        return false;
      },
    );
    expect(separatorFinder, findsWidgets);
  });

  testWidgets('wraps empty placeholder in ListView when refresh is enabled',
      (tester) async {
    await tester.pumpWidget(
      wrap(
        const DraftModeUIList<DraftModeListItem>(
          items: <DraftModeListItem>[],
          emptyPlaceholder: Text('Empty state'),
          onRefresh: _noopRefresh,
          itemBuilder: _noopBuilder,
        ),
      ),
    );

    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('Empty state'), findsOneWidget);
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

Future<void> _noopRefresh() async {}
