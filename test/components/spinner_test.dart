import 'package:draftmode_ui/components/spinner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('renders Cupertino activity indicator on iOS', (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    try {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: DraftModeUISpinner(),
        ),
      );

      expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
  });

  testWidgets('falls back to custom painter on non-iOS platforms',
      (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    try {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: DraftModeUISpinner(),
        ),
      );

      final customPaintFinder = find.byType(CustomPaint);
      expect(customPaintFinder, findsOneWidget);
      final CustomPaint customPaint = tester.widget(customPaintFinder);
      expect(customPaint.painter, isA<DraftModePageSpinnerPainter>());
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
  });

  test('custom spinner painter never repaints', () {
    final painterA = DraftModePageSpinnerPainter(
      strokeWidth: 2,
      color: const Color(0xFF000000),
    );
    final painterB = DraftModePageSpinnerPainter(
      strokeWidth: 2,
      color: const Color(0xFFFFFFFF),
    );

    expect(painterA.shouldRepaint(painterB), isFalse);
  });
}
