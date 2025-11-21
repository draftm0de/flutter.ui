import 'package:flutter/widgets.dart';

/// Global DraftMode UI helpers used to share references across widgets.
class DraftModeUIContext {
  DraftModeUIContext._();

  static final DraftModeUIContext instance = DraftModeUIContext._();

  BuildContext? _context;
  GlobalKey<NavigatorState>? _navigatorKey;

  /// Registers the navigator key or context used by shared widgets.
  static void init({
    GlobalKey<NavigatorState>? navigatorKey,
    BuildContext? context,
  }) {
    if (navigatorKey == null && context == null) {
      throw ArgumentError('Provide a navigatorKey or BuildContext.');
    }
    instance
      .._navigatorKey = navigatorKey
      .._context = context;
  }

  /// Returns either the provided context or the globally registered fallback.
  static BuildContext buildContext([BuildContext? context]) {
    final resolved =
        context ?? instance._navigatorKey?.currentContext ?? instance._context;
    if (resolved == null) {
      throw StateError(
        'Call DraftModeUIContext.init(navigatorKey: ...) or '
        'DraftModeUIContext.init(context: ...)',
      );
    }
    return resolved;
  }

  /// Used in tests to reset the shared references.
  @visibleForTesting
  static void debugReset() {
    instance
      .._context = null
      .._navigatorKey = null;
  }
}
