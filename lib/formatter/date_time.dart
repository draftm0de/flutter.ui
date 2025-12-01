/// Lightweight token-based formatter for rendering [Duration] values without
/// requiring the heavier `intl` dependency.
class DraftModeFormatterDateTime {
  /// Recognizes the supported duration tokens.
  static final RegExp _tokenMatcher = RegExp('DD|HH|mm|ss');

  /// Formats a [Duration] using the provided [pattern].
  ///
  /// Tokens:
  /// - `DD`: total days (zero padded to 2+ digits)
  /// - `HH`: hours remainder after days
  /// - `mm`: minutes remainder after hours
  /// - `ss`: seconds remainder after minutes
  /// Any other character sequence remains untouched, enabling literal text
  /// such as `ETA DD days HH:mm:ss`. Passing an empty [pattern] or a negative
  /// [value] throws [ArgumentError] to surface invalid input early.
  static String duration(Duration value, {required String pattern}) {
    if (pattern.isEmpty) {
      throw ArgumentError.value(pattern, 'pattern', 'Pattern cannot be empty');
    }
    if (value.isNegative) {
      throw ArgumentError.value(value, 'value', 'Duration must be positive');
    }

    final segments = _DurationSegments.fromDuration(value);
    return pattern.replaceAllMapped(
      _tokenMatcher,
      (match) => _resolveDateToken(segments, match[0]!),
    );
  }

  /// Resolves a single formatting [token] into the corresponding component.
  static String _resolveDateToken(_DurationSegments segments, String token) {
    switch (token) {
      case 'DD':
        return _padNumber(segments.days, width: 2);
      case 'HH':
        return _padNumber(segments.hours, width: 2);
      case 'mm':
        return _padNumber(segments.minutes, width: 2);
      case 'ss':
        return _padNumber(segments.seconds, width: 2);
      default:
        return token;
    }
  }

  static String _padNumber(int number, {int width = 2}) =>
      number.toString().padLeft(width, '0');
}

class _DurationSegments {
  const _DurationSegments({
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  final int days;
  final int hours;
  final int minutes;
  final int seconds;

  factory _DurationSegments.fromDuration(Duration duration) {
    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;
    return _DurationSegments(
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
    );
  }
}
