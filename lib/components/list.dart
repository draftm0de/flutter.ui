import 'package:flutter/widgets.dart';
import 'row.dart';
import 'spinner.dart';
import 'section.dart';
import '../styles.dart';

class DraftModeUIList<ItemType> extends StatelessWidget {
  final bool isPending;
  final List<ItemType> items;
  //final renderItem;
  final ItemType? selectedItem;
  final ValueChanged<ItemType>? onTap;
  final ValueChanged<ItemType>? onSelected;

  final Widget? emptyPlaceholder;
  final Widget? header;
  final Widget? separator;

  final Future<void> Function()? onRefresh;
  final EdgeInsetsGeometry? padding;

  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final ScrollController? controller;
  final bool? primary;

  const DraftModeUIList({
    super.key,
    this.isPending = false,

    required this.items,
    //required this.renderItem,
    this.selectedItem,
    this.onTap,
    this.onSelected,

    this.emptyPlaceholder,
    this.header,
    this.separator,

    this.onRefresh,
    this.padding,

    this.shrinkWrap = true,
    this.physics,
    this.controller,
    this.primary
  });

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (items.isEmpty) {
      final placeholder = (emptyPlaceholder == null)
          ? const SizedBox.shrink()
          : DraftModeUIRow(emptyPlaceholder!);
      content = _maybeWrapPlaceholder(context, placeholder);
    }
    else {
      final resolvedPadding = padding ?? _resolvedPadding(context);
      final resolvedPhysics = _resolvePhysics();
      if (separator != null) {
        final listView = ListView.separated(
          controller: controller,
          primary: primary,
          shrinkWrap: shrinkWrap,
          physics: resolvedPhysics,
          padding: resolvedPadding,
          itemBuilder: (context, index) => _buildListItem(context, items[index]),
          separatorBuilder: (context, index) => separator!,
          itemCount: items.length,
        );
        /*
        final Widget list = (onRefresh != null)
          ? DraftModeElementRefreshList(list: listView, onRefresh: onRefresh!)
          : listView;
         */
        final Widget list = listView;
        content = (header != null)
            ? Column(children: [header!, separator!, list])
            : list;
      } else {
        final listView = ListView.builder(
          controller: controller,
          primary: primary,
          shrinkWrap: shrinkWrap,
          physics: resolvedPhysics,
          padding: resolvedPadding,
          itemCount: items.length,
          itemBuilder: (context, index) => _buildListItem(context, items[index]),
        );
        /*
        final Widget list = (onRefresh != null)
            ? DraftModeElementRefreshList(list: listView, onRefresh: onRefresh!)
            : listView;
         */
        final Widget list = listView;
        content = (header != null) ? Column(children: [header!, list]) : list;
      }
    }

    if (!isPending) {
      return content;
    }

    return Stack(
      children: [
        content,
        Positioned.fill(
          child: IgnorePointer(
            ignoring: true,
            child: Align(
              alignment: Alignment.topCenter,
              child: SafeArea(
                top: true,
                bottom: false,
                child: SizedBox(
                  width: double.infinity,
                  child: DraftModeUIRow(const DraftModeUISpinner()),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _maybeWrapPlaceholder(BuildContext context, Widget child) {
    if (onRefresh == null) {
      return child;
    }

    final resolvedPadding = padding ?? _resolvedPadding(context);
    final resolvePhysics = _resolvePhysics() ?? const AlwaysScrollableScrollPhysics();
    final list = ListView(
      controller: controller,
      primary: primary,
      shrinkWrap: shrinkWrap,
      physics: resolvePhysics,
      padding: resolvedPadding,
      children: [child],
    );

    //return DraftModeElementRefreshList(list: list, onRefresh: onRefresh!);
    return list;
  }

  Widget _buildListItem(BuildContext context, ItemType item) {
    final selected = _isSelectedItem(item);
    //final wrapped = _maybeWrapWithDismissible(context, item, highlighted);
    final wrapped = Text('value');
    final keyed = KeyedSubtree(key: _getItemKey(item), child: wrapped);

    if (onTap == null && onSelected == null) {
      return keyed;
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _handleOnTap(item, selected),
      child: keyed,
    );
  }

  void _handleOnTap(ItemType item, bool isSelected) {
    onTap?.call(item);
    if (onSelected != null && !isSelected) {
      onSelected!(item);
    }
  }

  bool _isSelectedItem(ItemType item) {
    return false;
  }

  Key? _getItemKey(ItemType item) {
    return null;
  }

  ScrollPhysics? _resolvePhysics() {
    final basePhysics =
        physics ?? (shrinkWrap ? const NeverScrollableScrollPhysics() : null);

    if (onRefresh == null) {
      return basePhysics;
    }

    if (basePhysics == null) {
      return const AlwaysScrollableScrollPhysics();
    }

    if (basePhysics is NeverScrollableScrollPhysics) {
      return const AlwaysScrollableScrollPhysics();
    }

    return AlwaysScrollableScrollPhysics(parent: basePhysics);
  }

  EdgeInsetsGeometry _resolvedPadding(BuildContext context) {
    if (DraftModeUISectionScope.isInSection(context)) {
      return EdgeInsets.zero;
    }

    return EdgeInsets.symmetric(
      horizontal: DraftModeUIStylePadding.primary,
      vertical: DraftModeUIStylePadding.primary,
    );
  }
}
