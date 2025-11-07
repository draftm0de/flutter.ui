import 'dart:async';
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as m;

import 'l10n/app_localizations.dart';

enum DraftModeUIConfirmStyle { confirm, error }

/// Platform-aware confirmation dialog that falls back to sensible defaults.
///
/// Use the static [show] helper to display it. The widget keeps track of an
/// optional auto-confirm countdown so the UI can surface the remaining time
/// and dismiss itself when the timer expires. When custom labels are omitted
/// the component uses strings from [AppLocalizations].
class DraftModeUIConfirm extends StatefulWidget {
  final String title;
  final String message;
  final String? confirmLabel;
  final String? cancelLabel;
  final DraftModeUIConfirmStyle mode;
  final Duration? autoConfirm;

  const DraftModeUIConfirm({
    super.key,
    required this.title,
    required this.message,
    this.confirmLabel,
    this.cancelLabel,
    this.mode = DraftModeUIConfirmStyle.confirm,
    this.autoConfirm,
  });

  static bool get isIOS => defaultTargetPlatform == TargetPlatform.iOS;

  /// Displays the dialog using platform-aware styling and returns the choice.
  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String message,
    String? confirmLabel,
    String? cancelLabel,
    bool? barrierDismissible,
    DraftModeUIConfirmStyle mode = DraftModeUIConfirmStyle.confirm,
    Duration? autoConfirm,
  }) async {

    final bool dismissible = barrierDismissible ?? !isIOS;

    if (isIOS) {
      return showCupertinoDialog<bool>(
        context: context,
        barrierDismissible: dismissible,
        builder: (_) => DraftModeUIConfirm(
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
      context: context,
      barrierDismissible: dismissible,
      builder: (_) => DraftModeUIConfirm(
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
  State<DraftModeUIConfirm> createState() => _DraftModeUIConfirmState();
}

class _DraftModeUIConfirmState extends State<DraftModeUIConfirm> {
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

  static bool get isIOS => defaultTargetPlatform == TargetPlatform.iOS;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final String confirmBtn =
        widget.confirmLabel ?? localization?.btnConfirmYes ?? 'Yes';
    final String cancelBtn =
        widget.cancelLabel ?? localization?.btnConfirmNo ?? 'No';
    final bool isError = widget.mode == DraftModeUIConfirmStyle.error;
    final bool showCancelButton = !isError;

    final hasCountdown = widget.autoConfirm != null && _secondsLeft > 0;
    final countdownValue = secondToMMSS(_secondsLeft);
    final countdownText = hasCountdown
        ? (localization?.autoConfirmCountdown(countdownValue) ??
            'Automatically confirms in $countdownValue')
        : null;
    final String finalMessage = countdownText == null
        ? widget.message
        : '${widget.message}\n$countdownText';

    if (isIOS) {
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
