import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as m;
import 'package:draftmode_localization/localizations.dart';
import 'package:draftmode_ui/platform.dart';
import 'package:draftmode_ui/context.dart';

enum DraftModeUIDialogStyle { confirm, error }

/// Platform-aware confirmation dialog that falls back to sensible defaults.
///
/// Use the static [show] helper to display it. The widget keeps track of an
/// optional auto-confirm countdown so the UI can surface the remaining time
/// and dismiss itself when the timer expires. When custom labels are omitted
/// the component uses strings from [DraftModeLocalizations].
class DraftModeUIDialog extends StatefulWidget {
  final String title;
  final String message;
  final String? confirmLabel;
  final String? cancelLabel;
  final DraftModeUIDialogStyle mode;
  final Duration? autoConfirm;

  const DraftModeUIDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmLabel,
    this.cancelLabel,
    this.mode = DraftModeUIDialogStyle.confirm,
    this.autoConfirm,
  });

  /// Displays the dialog using platform-aware styling and returns the choice.
  ///
  /// Provide a [context] argument or call [DraftModeUIContext.init] earlier in
  /// the app lifecycle so the helper can derive a fallback navigator context.
  static Future<bool?> show({
    BuildContext? context,
    required String title,
    required String message,
    String? confirmLabel,
    String? cancelLabel,
    bool? barrierDismissible,
    DraftModeUIDialogStyle mode = DraftModeUIDialogStyle.confirm,
    Duration? autoConfirm,
  }) async {
    final resolvedContext = DraftModeUIContext.buildContext(context);
    final bool dismissible = barrierDismissible ?? !DraftModeUIPlatform.isIOS;

    if (DraftModeUIPlatform.isIOS) {
      return showCupertinoDialog<bool>(
        context: resolvedContext,
        barrierDismissible: dismissible,
        builder: (_) => DraftModeUIDialog(
          title: title,
          message: message,
          confirmLabel: confirmLabel,
          cancelLabel: cancelLabel,
          mode: mode,
          autoConfirm: autoConfirm,
        ),
      );
    }

    return m.showDialog<bool>(
      context: resolvedContext,
      barrierDismissible: dismissible,
      builder: (_) => DraftModeUIDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        mode: mode,
        autoConfirm: autoConfirm,
      ),
    );
  }

  @override
  State<DraftModeUIDialog> createState() => _DraftModeUIDialogState();
}

class _DraftModeUIDialogState extends State<DraftModeUIDialog> {
  Timer? _timer;
  late int _secondsLeft;

  @override
  void initState() {
    super.initState();
    final autoConfirm = widget.autoConfirm;
    if (autoConfirm == null) {
      _secondsLeft = 0;
      return;
    }

    final totalSeconds = autoConfirm.inSeconds;
    _secondsLeft = totalSeconds;

    if (totalSeconds <= 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _confirm(true));
      return;
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft <= 1) {
        _confirm(true);
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  void _confirm(bool confirmAs) {
    _timer?.cancel();
    _timer = null;
    if (!mounted) return;
    Navigator.of(context).pop(confirmAs);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  /// Converts a second count into the `mm:ss` string used in the countdown.
  static String secondToMMSS(int seconds) {
    final total = seconds < 0 ? 0 : seconds;
    final minutes = total ~/ 60;
    final remainder = total % 60;
    return '${minutes.toString().padLeft(2, '0')}'
        ':${remainder.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final localization = DraftModeLocalizations.of(context);
    final String confirmBtn =
        widget.confirmLabel ?? localization?.btnConfirmYes ?? 'Yes';
    final String cancelBtn =
        widget.cancelLabel ?? localization?.btnConfirmNo ?? 'No';
    final bool isError = widget.mode == DraftModeUIDialogStyle.error;
    final bool showCancelButton = !isError;

    final hasCountdown = widget.autoConfirm != null && _secondsLeft > 0;
    final countdownValue = secondToMMSS(_secondsLeft);
    final countdownText = hasCountdown
        ? (localization?.workerAutoConfirmIn(time: countdownValue) ??
            'Automatically confirms in $countdownValue')
        : null;
    final String finalMessage = countdownText == null
        ? widget.message
        : '${widget.message}\n$countdownText';

    if (DraftModeUIPlatform.isIOS) {
      return CupertinoAlertDialog(
        title: Text(widget.title),
        content: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(finalMessage),
        ),
        actions: [
          if (showCancelButton)
            CupertinoDialogAction(
              onPressed: () => _confirm(false),
              child: Text(cancelBtn),
            ),
          CupertinoDialogAction(
            isDefaultAction: !isError,
            isDestructiveAction: isError,
            onPressed: () => _confirm(true),
            child: Text(confirmBtn),
          ),
        ],
      );
    }

    return m.AlertDialog(
      title: m.Text(widget.title),
      content: m.Text(finalMessage),
      actions: [
        if (showCancelButton)
          m.TextButton(
            onPressed: () => _confirm(false),
            child: m.Text(cancelBtn),
          ),
        m.TextButton(
          style: isError
              ? m.TextButton.styleFrom(
                  foregroundColor: m.Theme.of(context).colorScheme.error,
                )
              : null,
          onPressed: () => _confirm(true),
          child: m.Text(confirmBtn),
        ),
      ],
    );
  }
}
