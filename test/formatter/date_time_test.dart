import 'package:draftmode_ui/formatter/date_time.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DraftModeFormatterDateTime.duration', () {
    test('formats duration with sequential tokens', () {
      final duration = Duration(days: 2, hours: 5, minutes: 7, seconds: 9);

      final formatted = DraftModeFormatterDateTime.duration(
        duration,
        pattern: 'DDHHmmss',
      );

      expect(formatted, '02050709');
    });

    test('supports every documented token', () {
      final duration = Duration(days: 4, hours: 3, minutes: 2, seconds: 1);

      final formatted = DraftModeFormatterDateTime.duration(
        duration,
        pattern: 'Days: DD Hours: HH Minutes: mm Seconds: ss',
      );

      expect(formatted, 'Days: 04 Hours: 03 Minutes: 02 Seconds: 01');
    });

    test('keeps literal text untouched', () {
      final duration = Duration(days: 1, hours: 12, minutes: 7);

      final formatted = DraftModeFormatterDateTime.duration(
        duration,
        pattern: 'ETA DD days HH:mm:ss',
      );

      expect(formatted, 'ETA 01 days 12:07:00');
    });

    test('wraps remainder components correctly', () {
      final duration = Duration(hours: 49, minutes: 61, seconds: 3661);

      final formatted = DraftModeFormatterDateTime.duration(
        duration,
        pattern: 'DD:HH:mm:ss',
      );

      // Extra minutes/seconds roll into the higher units, leaving remainders below 60.
      expect(formatted, '02:03:02:01');
    });

    test('handles zero duration with padding', () {
      final formatted = DraftModeFormatterDateTime.duration(
        Duration.zero,
        pattern: 'DD:HH:mm:ss',
      );

      expect(formatted, '00:00:00:00');
    });

    test('throws when duration is negative', () {
      expect(
        () => DraftModeFormatterDateTime.duration(
          const Duration(seconds: -1),
          pattern: 'ss',
        ),
        throwsArgumentError,
      );
    });

    test('throws when pattern is empty', () {
      expect(
        () => DraftModeFormatterDateTime.duration(
          const Duration(seconds: 1),
          pattern: '',
        ),
        throwsArgumentError,
      );
    });
  });
}
