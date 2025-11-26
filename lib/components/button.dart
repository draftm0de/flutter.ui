import 'package:draftmode_ui/platform.dart';
import 'package:draftmode_ui/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as material;

class DraftModeUIButton extends StatelessWidget {
  final Widget child;
  final Widget? pendingChild;
  final bool isPending;
  final VoidCallback? onPressed;
  final DraftModeUIStyleButtonSize? styleSize;
  final DraftModeUIStyleButtonColor? styleColor;
  final bool stretched;

  const DraftModeUIButton({
    super.key,
    required this.child,
    this.pendingChild,
    this.isPending = false,
    this.onPressed,
    this.styleSize,
    this.styleColor,
    this.stretched = true,
  });

  /// Creates a button that renders the provided [text] with DraftMode sizing
  /// tokens. Callers can override the generated [Text] styling via
  /// [textStyle], [textAlign], [maxLines], or [overflow].
  factory DraftModeUIButton.text(
    String text, {
    Key? key,
    Widget? pendingChild,
    bool isPending = false,
    VoidCallback? onPressed,
    DraftModeUIStyleButtonSize? styleSize,
    DraftModeUIStyleButtonColor? styleColor,
    bool stretched = true,
    TextStyle? textStyle,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    final resolvedSize = styleSize ?? DraftModeUIStyleButtonSizes.large;
    final resolvedColor = styleColor ?? DraftModeUIStyleButtonColors.submit;
    return DraftModeUIButton(
      key: key,
      pendingChild: pendingChild,
      isPending: isPending,
      onPressed: onPressed,
      styleSize: styleSize,
      styleColor: styleColor,
      stretched: stretched,
      child: Text(
        text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        style: textStyle ??
            TextStyle(
              fontSize: resolvedSize.fontSize,
              fontWeight: resolvedSize.fontWeight,
              color: resolvedColor.font,
            ),
      ),
    );
  }

  CupertinoButtonSize _resolveCupertinoSize() {
    if (styleSize == DraftModeUIStyleButtonSizes.medium) {
      return CupertinoButtonSize.medium;
    }
    if (styleSize == DraftModeUIStyleButtonSizes.small) {
      return CupertinoButtonSize.small;
    }
    return CupertinoButtonSize.large;
  }

  Color? _resolveBackgroundColor() {
    return (styleColor != null)
        ? styleColor!.background
        : DraftModeUIStyleButtonColors.submit.background;
  }

  double _resolveHeight() {
    if (styleSize == DraftModeUIStyleButtonSizes.medium) {
      return DraftModeUIStyleButtonSizes.medium.height;
    }
    if (styleSize == DraftModeUIStyleButtonSizes.small) {
      return DraftModeUIStyleButtonSizes.small.height;
    }
    return DraftModeUIStyleButtonSizes.large.height;
  }

  Widget _buildCupertino() {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      sizeStyle: _resolveCupertinoSize(),
      borderRadius: BorderRadius.circular(12),
      color: _resolveBackgroundColor(),
      onPressed: isPending ? null : onPressed,
      child: isPending && pendingChild != null ? pendingChild! : child,
    );
  }

  Widget _buildMaterial(BuildContext context) {
    final height = _resolveHeight();
    final baseStyle = material.FilledButton.styleFrom(
      backgroundColor: _resolveBackgroundColor(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      minimumSize: Size(0, height),
      padding: const EdgeInsets.symmetric(horizontal: 16),
    );
    final style = stretched
        ? baseStyle.copyWith(
            fixedSize: WidgetStatePropertyAll(Size.fromHeight(height)),
          )
        : baseStyle;
    return material.FilledButton(
      style: style,
      onPressed: isPending ? null : onPressed,
      child: isPending && pendingChild != null ? pendingChild! : child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final button =
        DraftModeUIPlatform.isIOS ? _buildCupertino() : _buildMaterial(context);
    if (!stretched) return button;
    return SizedBox(width: double.infinity, child: button);
  }
}
