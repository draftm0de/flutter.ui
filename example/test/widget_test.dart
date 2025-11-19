import 'package:draftmode_ui_example/app.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders DraftMode UI demo page', (tester) async {
    await tester.pumpWidget(App(navigatorKey: GlobalKey<NavigatorState>()));

    expect(find.text('DraftMode UI'), findsOneWidget);
    expect(find.text('Destination'), findsOneWidget);
  });
}
