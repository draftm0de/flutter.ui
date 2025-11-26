import 'package:draftmode_ui/components/button.dart';
import 'package:draftmode_ui/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() => debugDefaultTargetPlatformOverride = null);
  tearDown(() => debugDefaultTargetPlatformOverride = null);

  testWidgets('renders Cupertino button when platform is iOS', (tester) async {
    await _withTargetPlatform(TargetPlatform.iOS, () async {
      await tester.pumpWidget(
        WidgetsApp(
          color: const Color(0xFFFFFFFF),
          builder: (_, __) => DraftModeUIButton(
            pendingChild: const Text('Pending'),
            isPending: true,
            styleSize: DraftModeUIStyleButtonSizes.small,
            styleColor: DraftModeUIStyleButtonColors.inline,
            child: const Text('Primary'),
          ),
        ),
      );

      expect(find.byType(CupertinoButton), findsOneWidget);
      expect(find.text('Pending'), findsOneWidget);
    });
  });

  testWidgets('renders stretched Material button when platform is not iOS', (
    tester,
  ) async {
    await _withTargetPlatform(TargetPlatform.android, () async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DraftModeUIButton(
              styleSize: DraftModeUIStyleButtonSizes.medium,
              styleColor: DraftModeUIStyleButtonColors.submit,
              stretched: true,
              child: const Text('Submit'),
            ),
          ),
        ),
      );

      expect(find.byType(FilledButton), findsOneWidget);
      final sizedBox = tester.widget<SizedBox>(
        find.byWidgetPredicate(
          (widget) => widget is SizedBox && widget.width == double.infinity,
        ),
      );
      expect(sizedBox.width, double.infinity);
    });
  });

  testWidgets('uses default sizing when stretched is false', (tester) async {
    await _withTargetPlatform(TargetPlatform.android, () async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DraftModeUIButton(
              stretched: false,
              onPressed: () {},
              child: const Text('Default'),
            ),
          ),
        ),
      );

      expect(find.byType(FilledButton), findsOneWidget);
      expect(
        find.byWidgetPredicate(
          (widget) => widget is SizedBox && widget.width == double.infinity,
        ),
        findsNothing,
      );
    });
  });

  testWidgets('falls back to original child when pendingChild missing', (
    tester,
  ) async {
    await _withTargetPlatform(TargetPlatform.android, () async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DraftModeUIButton(
              stretched: false,
              isPending: true,
              styleSize: DraftModeUIStyleButtonSizes.small,
              child: const Text('Fallback'),
            ),
          ),
        ),
      );

      expect(find.text('Fallback'), findsOneWidget);
      final button = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(button.onPressed, isNull);
    });
  });

  testWidgets('text factory wires styles to the generated Text widget', (
    tester,
  ) async {
    await _withTargetPlatform(TargetPlatform.android, () async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DraftModeUIButton.text(
              'Factory label',
              styleSize: DraftModeUIStyleButtonSizes.small,
              styleColor: DraftModeUIStyleButtonColors.inline,
            ),
          ),
        ),
      );

      final text = tester.widget<Text>(find.text('Factory label'));
      expect(text.style?.fontSize, DraftModeUIStyleButtonSizes.small.fontSize);
      expect(
          text.style?.fontWeight, DraftModeUIStyleButtonSizes.small.fontWeight);
      expect(text.style?.color, DraftModeUIStyleButtonColors.inline.font);
    });
  });
}

Future<void> _withTargetPlatform(
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
