import 'package:draftmode_ui/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
      'DraftModeUIPageExample shows header, navigation title, and injected children',
      (tester) async {
    const title = 'Demo gallery';
    const childLabel = 'Custom child';

    await tester.pumpWidget(
      const CupertinoApp(
        home: DraftModeUIPageExample(
          title: title,
          children: [Text(childLabel)],
        ),
      ),
    );

    expect(find.widgetWithText(CupertinoNavigationBar, title), findsOneWidget);
    expect(find.text('DraftMode'), findsOneWidget);
    expect(find.text('Development is infinite.'), findsOneWidget);
    expect(find.text(childLabel), findsOneWidget);
    expect(find.byType(SafeArea), findsWidgets);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
  });

  testWidgets('DraftModeUIPageExample scrolls overflowing content',
      (tester) async {
    await tester.pumpWidget(
      CupertinoApp(
        home: DraftModeUIPageExample(
          title: 'Demo gallery',
          children: List.generate(
            20,
            (index) => SizedBox(
              height: 80,
              child: Text('Child $index'),
            ),
          ),
        ),
      ),
    );

    expect(find.byType(SingleChildScrollView), findsOneWidget);

    await tester.dragUntilVisible(
      find.text('Child 19'),
      find.byType(SingleChildScrollView),
      const Offset(0, -80),
    );

    expect(find.text('Child 19'), findsOneWidget);
  });
}
