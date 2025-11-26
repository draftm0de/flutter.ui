import 'package:draftmode_ui/buttons.dart';
import 'package:draftmode_ui/components/list.dart';
import 'package:draftmode_ui/components/row.dart';
import 'package:draftmode_ui/components/section.dart';
import 'package:draftmode_ui/components/spinner.dart';
import 'package:draftmode_ui/pages.dart';
import 'package:draftmode_ui/platform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Platform-aware disclosure that surfaces a full-page list picker.
///
/// Displays the current selection inline (mirroring [DraftModeUIRow]) and pushes
/// a `DraftModeUIPage` with a selectable [DraftModeUIList] when tapped. All list
/// customisation hooks (headers, separators, refresh controls, padding) are
/// forwarded to the sheet so drop-downs stay visually aligned with standalone
/// lists.
class DraftModeUIDropDown<ItemType> extends StatelessWidget {
  final bool isPending;
  final List<ItemType> items;
  final Widget Function(ItemType item, bool isSelected) itemBuilder;
  final String pageTitle;
  final ItemType? selectedItem;
  final ValueChanged<ItemType?>? onChanged;

  final Widget? emptyPlaceholder;
  final Widget? header;
  final Widget? separator;

  final Future<void> Function()? onRefresh;
  final EdgeInsetsGeometry? padding;
  final bool readOnly;

  const DraftModeUIDropDown({
    super.key,
    this.isPending = false,
    required this.items,
    required this.itemBuilder,
    required this.pageTitle,
    this.selectedItem,
    this.onChanged,
    this.emptyPlaceholder,
    this.header,
    this.separator,
    this.onRefresh,
    this.padding,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isPending) {
      return const DraftModeUIRow(DraftModeUISpinner());
    }

    final selected = selectedItem;
    final Widget itemContent = (selected != null)
        ? itemBuilder(selected, true)
        : (emptyPlaceholder ?? const SizedBox.shrink());
    final Widget content = _wrapWithIcon(itemContent);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: readOnly ? null : () => _openDialog(context),
      child: DraftModeUIRow(content),
    );
  }

  Widget _wrapWithIcon(Widget selectedContent) {
    final content = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: selectedContent),
        Icon(DraftModeUIButtons.arrowRight, size: 16),
      ],
    );
    return content;
  }

  Future<void> _openDialog(BuildContext context) async {
    final screen = DraftModeUIDropDownScreen<ItemType>(
      pageTitle: pageTitle,
      items: items,
      selectedItem: selectedItem,
      itemBuilder: itemBuilder,
      emptyPlaceholder: emptyPlaceholder,
      header: header,
      separator: separator,
      onRefresh: onRefresh,
      padding: padding,
    );
    final item = await Navigator.of(context).push<ItemType>(
      DraftModeUIPlatform.isIOS
          ? CupertinoPageRoute(builder: (_) => screen)
          : MaterialPageRoute(builder: (_) => screen),
    );
    onChanged?.call(item);
  }
}

/// Selection sheet pushed by [DraftModeUIDropDown]. Extracted so navigation
/// follows the DraftMode page scaffolding and localisation helpers while
/// reusing the shared list styling hooks.
class DraftModeUIDropDownScreen<ItemType> extends StatefulWidget {
  final String pageTitle;
  final List<ItemType> items;
  final ItemType? selectedItem;
  final Widget Function(ItemType item, bool isSelected) itemBuilder;
  final Widget? emptyPlaceholder;
  final Widget? header;
  final Widget? separator;
  final Future<void> Function()? onRefresh;
  final EdgeInsetsGeometry? padding;

  const DraftModeUIDropDownScreen({
    required this.pageTitle,
    required this.items,
    required this.itemBuilder,
    this.emptyPlaceholder,
    this.header,
    this.separator,
    this.onRefresh,
    this.padding,
    this.selectedItem,
    super.key,
  });

  void setItem(BuildContext context, ItemType item) {
    if (!Navigator.of(context).canPop()) return;
    Navigator.of(context).pop<ItemType>(item);
  }

  @override
  State<DraftModeUIDropDownScreen<ItemType>> createState() =>
      _DraftModeUIDropDownScreenState<ItemType>();
}

class _DraftModeUIDropDownScreenState<ItemType>
    extends State<DraftModeUIDropDownScreen<ItemType>> {
  @override
  Widget build(BuildContext context) {
    final Widget body = DraftModeUIList(
      items: widget.items,
      selectedItem: widget.selectedItem,
      itemBuilder: widget.itemBuilder,
      emptyPlaceholder: widget.emptyPlaceholder,
      header: widget.header,
      separator: widget.separator,
      onRefresh: widget.onRefresh,
      padding: widget.padding,
      onTap: (item) {
        widget.setItem(context, item);
      },
    );
    Widget section = DraftModeUISection(children: [body]);
    if (!DraftModeUIPlatform.isIOS) {
      section = Padding(
        padding: DraftModeUISectionScope.containerPadding,
        child: section,
      );
    }
    return DraftModeUIPage(
      navigationTitle: widget.pageTitle,
      horizontalContainerPadding: 0,
      verticalContainerPadding: 0,
      body: section,
    );
  }
}
