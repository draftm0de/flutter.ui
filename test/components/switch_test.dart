import 'package:draftmode_ui/components/switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('renders Cupertino switch on iOS and forwards callbacks',
      (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    bool? toggled;

    try {
      await tester.pumpWidget(
        CupertinoApp(
          home: DraftModeUISwitch(
            value: false,
            onChanged: (value) => toggled = value,
          ),
        ),
      );

      final cupertinoFinder = find.byType(CupertinoSwitch);
      expect(cupertinoFinder, findsOneWidget);

      await tester.tap(cupertinoFinder);
      await tester.pump();

      expect(toggled, isTrue);
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
  });

  testWidgets('falls back to Material Switch on non-iOS platforms',
      (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    bool? toggled;

    try {
      await tester.pumpWidget(
        material.MaterialApp(
          home: material.Scaffold(
            body: DraftModeUISwitch(
              value: true,
              onChanged: (value) => toggled = value,
            ),
          ),
        ),
      );

      final switchFinder = find.byType(material.Switch);
      expect(switchFinder, findsOneWidget);

      await tester.tap(switchFinder);
      await tester.pump();

      expect(toggled, isFalse);
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
  });

  testWidgets('defaults to false when no value is supplied', (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;

    try {
      await tester.pumpWidget(
        material.MaterialApp(
          home: material.Scaffold(
            body: DraftModeUISwitch(
              onChanged: (_) {},
            ),
          ),
        ),
      );

      final material.Switch materialSwitch =
          tester.widget(find.byType(material.Switch));
      expect(materialSwitch.value, isFalse);
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
  });
}
