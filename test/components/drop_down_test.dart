import 'package:draftmode_ui/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders selected item through builder', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DraftModeUIDropDown<int>(
          pageTitle: 'Title',
          items: const [0, 1],
          selectedItem: 1,
          itemBuilder: (item, isSelected) {
            return Text('item-$item-selected-$isSelected');
          },
        ),
      ),
    );

    expect(find.text('item-1-selected-true'), findsOneWidget);
  });

  testWidgets('shows empty placeholder when no selection exists',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DraftModeUIDropDown<int>(
          pageTitle: 'Title',
          items: const [0, 1],
          itemBuilder: (_, __) => const Text('unused'),
          emptyPlaceholder: const Text('tap to choose'),
        ),
      ),
    );

    expect(find.text('tap to choose'), findsOneWidget);
  });

  testWidgets('tapping opens sheet and returns selected item', (tester) async {
    DraftModeListItem? selected;
    final items = [
      const DraftModeListItem(id: 0, value: 'Alpha'),
      const DraftModeListItem(id: 1, value: 'Beta'),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: DraftModeUIDropDown<DraftModeListItem>(
          pageTitle: 'Pick option',
          items: items,
          selectedItem: items.first,
          itemBuilder: (item, _) => Text(item.value as String),
          onChanged: (item) => selected = item,
        ),
      ),
    );

    await tester.tap(find.text('Alpha'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Beta'));
    await tester.pumpAndSettle();

    expect(selected, same(items.last));
  });

  testWidgets('readOnly drop-down does not navigate', (tester) async {
    bool didChange = false;

    await tester.pumpWidget(
      MaterialApp(
        home: DraftModeUIDropDown<int>(
          pageTitle: 'Locked',
          items: const [1, 2],
          selectedItem: 1,
          readOnly: true,
          itemBuilder: (item, _) => Text('Item $item'),
          onChanged: (_) => didChange = true,
        ),
      ),
    );

    await tester.tap(find.text('Item 1'));
    await tester.pumpAndSettle();

    expect(didChange, isFalse);
  });

  testWidgets('pending state renders spinner row', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DraftModeUIDropDown<int>(
          pageTitle: 'Loading',
          items: const [1],
          isPending: true,
          itemBuilder: (_, __) => const Text('unused'),
        ),
      ),
    );

    expect(find.byType(DraftModeUISpinner), findsOneWidget);
  });

  testWidgets('drop-down sheet avoids duplicate section padding on iOS',
      (tester) async {
    await _withPlatform(TargetPlatform.iOS, () async {
      await tester.pumpWidget(
        CupertinoApp(
          home: DraftModeUIDropDownScreen<int>(
            pageTitle: 'Options',
            items: const [1, 2],
            itemBuilder: (item, _) => Text('Option $item'),
          ),
        ),
      );

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Padding &&
              widget.padding == DraftModeUISectionScope.containerPadding,
        ),
        findsNothing,
      );
    });
  });

  testWidgets('drop-down sheet keeps section margin on Material',
      (tester) async {
    await _withPlatform(TargetPlatform.android, () async {
      await tester.pumpWidget(
        MaterialApp(
          home: DraftModeUIDropDownScreen<int>(
            pageTitle: 'Options',
            items: const [1, 2],
            itemBuilder: (item, _) => Text('Option $item'),
          ),
        ),
      );

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Padding &&
              widget.padding == DraftModeUISectionScope.containerPadding,
        ),
        findsOneWidget,
      );
    });
  });

  testWidgets('drop-down pushes Material route when not on iOS',
      (tester) async {
    await _withPlatform(TargetPlatform.android, () async {
      final observer = _RecordingNavigatorObserver();
      await tester.pumpWidget(
        MaterialApp(
          navigatorObservers: [observer],
          home: DraftModeUIDropDown<int>(
            pageTitle: 'Route test',
            items: const [1, 2],
            selectedItem: 1,
            itemBuilder: (item, _) => Text('Item $item'),
          ),
        ),
      );

      observer.reset();
      await tester.tap(find.text('Item 1'));
      await tester.pumpAndSettle();

      expect(observer.latestRoute, isA<MaterialPageRoute<dynamic>>());

      observer.latestRoute?.navigator?.pop();
      await tester.pumpAndSettle();
    });
  });

  testWidgets('drop-down pushes Cupertino route on iOS', (tester) async {
    await _withPlatform(TargetPlatform.iOS, () async {
      final observer = _RecordingNavigatorObserver();
      await tester.pumpWidget(
        CupertinoApp(
          navigatorObservers: [observer],
          home: DraftModeUIDropDown<int>(
            pageTitle: 'Route test',
            items: const [1, 2],
            selectedItem: 1,
            itemBuilder: (item, _) => Text('Cupertino $item'),
          ),
        ),
      );

      observer.reset();
      await tester.tap(find.text('Cupertino 1'));
      await tester.pumpAndSettle();

      expect(observer.latestRoute, isA<CupertinoPageRoute<dynamic>>());

      observer.latestRoute?.navigator?.pop();
      await tester.pumpAndSettle();
    });
  });
}

Future<void> _withPlatform(
  TargetPlatform platform,
  Future<void> Function() body,
) async {
  final previous = debugDefaultTargetPlatformOverride;
  debugDefaultTargetPlatformOverride = platform;
  try {
    await body();
  } finally {
    debugDefaultTargetPlatformOverride = previous;
  }
}

class _RecordingNavigatorObserver extends NavigatorObserver {
  Route<dynamic>? latestRoute;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    latestRoute = route;
    super.didPush(route, previousRoute);
  }

  void reset() => latestRoute = null;
}
