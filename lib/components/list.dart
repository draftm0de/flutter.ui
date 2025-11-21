import 'package:flutter/cupertino.dart';

import 'package:draftmode_ui/buttons.dart';
import 'package:draftmode_ui/styles.dart';
import 'row.dart';
import 'spinner.dart';

/// Lightweight data record used by [DraftModeUIList].
///
/// Each item stores a stable [id] used for keys plus the [value] object passed
/// to [DraftModeUIList.itemBuilder]. The class intentionally keeps the fields
/// as `dynamic` so host apps can surface domain-specific types without casting.
class DraftModeListItem {
  final dynamic id;
  final dynamic value;

  const DraftModeListItem({
    required this.id,
    required this.value,
  });
}

/// Convenience helpers for composing [DraftModeListItem] collections.
class DraftModeListItemBuilder {
  /// Maps a [Map]'s entries to [DraftModeListItem]s while preserving insertion
  /// order. Handy when the data already lives in a keyed cache.
  static List<DraftModeListItem> fromMap(Map<dynamic, dynamic> map) {
    return map.entries
        .map(
          (entry) => DraftModeListItem(
            id: entry.key,
            value: entry.value,
          ),
        )
        .toList();
  }
}

class DraftModeUIList<ItemType> extends StatelessWidget {
  final bool isPending;
  final List<ItemType> items;
  final Widget Function(ItemType item, bool isSelected) itemBuilder;
  final ItemType? selectedItem;
  final ValueChanged<ItemType>? onTap;

  final Widget? emptyPlaceholder;
  final Widget? header;
  final Widget? separator;

  final Future<void> Function()? onRefresh;
  final EdgeInsetsGeometry? padding;

  /// Platform-aware grouped list with DraftMode's row styling baked in.
  ///
  /// When [items] is empty the widget renders [emptyPlaceholder] (falling back
  /// to a zero-sized box) wrapped in a [DraftModeUIRow] so it lines up with
  /// other grouped elements. The list always draws a platform-aligned divider
  /// between rows; override [separator] (or pass `SizedBox.shrink()`) to change
  /// or remove the default dashed line. Provide [header] for leading content
  /// (commonly a [DraftModeUIRow] label).
  /// Supplying [onRefresh] automatically switches to a `CustomScrollView` with
  /// `CupertinoSliverRefreshControl` while still honoring the list's original
  /// configuration and [padding]. Selection relies on identity equality, so
  /// pass the exact item instance to [selectedItem] when you want the trailing
  /// check icon to render.
  const DraftModeUIList({
    super.key,
    this.isPending = false,
    required this.items,
    required this.itemBuilder,
    this.selectedItem,
    this.onTap,
    this.emptyPlaceholder,
    this.header,
    this.separator,
    this.onRefresh,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (items.isEmpty) {
      final placeholder = (emptyPlaceholder == null)
          ? const SizedBox.shrink()
          : DraftModeUIRow(emptyPlaceholder!);
      content = _wrapWithPlaceholder(context, placeholder);
    } else {
      final listView = ListView.separated(
        shrinkWrap: true,
        padding: padding,
        itemBuilder: (context, index) => _buildListItem(context, items[index]),
        separatorBuilder: (context, index) => _buildSeparatorWidget(),
        itemCount: items.length,
      );
      final Widget list =
          (onRefresh != null) ? _buildRefreshList(listView) : listView;
      content = (header != null)
          ? Column(children: [header!, _buildSeparatorWidget(), list])
          : list;
    }

    if (isPending) {
      return DraftModeUIRow(const DraftModeUISpinner());
    }

    return content;
  }

  Widget _buildSeparatorWidget() {
    final custom = separator;
    if (custom != null) {
      return custom;
    }
    return _defaultSeparator();
  }

  Widget _defaultSeparator() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: DraftModeUIStylePadding.primary),
      height: 0.5,
      color: CupertinoColors.separator,
    );
  }

  Widget _wrapWithPlaceholder(BuildContext context, Widget child) {
    if (onRefresh == null) {
      return child;
    }

    final list = ListView(
      shrinkWrap: true,
      children: [child],
    );

    return list;
  }

  Widget _buildListItem(BuildContext context, ItemType item) {
    Widget content;
    final bool isSelected = _isSelectedItem(item);
    content = DraftModeUIRow(itemBuilder(item, isSelected));
    content = _wrapItemWidgetWithSelection(content, isSelected);
    final keyed = KeyedSubtree(key: _getItemKey(item), child: content);

    if (onTap == null) {
      return keyed;
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap?.call(item),
      child: keyed,
    );
  }

  Widget _buildRefreshList(ListView list) {
    final ScrollPhysics physics = BouncingScrollPhysics(
      parent: list.physics ?? const AlwaysScrollableScrollPhysics(),
    );

    Widget sliver = SliverList(delegate: list.childrenDelegate);

    final EdgeInsetsGeometry? padding = list.padding;
    if (padding != null) {
      sliver = SliverPadding(padding: padding, sliver: sliver);
    }

    return CustomScrollView(
      scrollDirection: list.scrollDirection,
      reverse: list.reverse,
      primary: list.primary,
      physics: physics,
      shrinkWrap: list.shrinkWrap,
      cacheExtent: list.cacheExtent,
      semanticChildCount: list.semanticChildCount,
      dragStartBehavior: list.dragStartBehavior,
      keyboardDismissBehavior: list.keyboardDismissBehavior,
      restorationId: list.restorationId,
      clipBehavior: list.clipBehavior,
      slivers: [
        CupertinoSliverRefreshControl(onRefresh: onRefresh),
        sliver,
      ],
    );
  }

  bool _isSelectedItem(ItemType item) {
    final selected = selectedItem;
    if (selected == null) {
      return false;
    }
    return identical(selected, item);
  }

  Key _getItemKey(ItemType item) {
    return ObjectKey(item);
  }

  Widget _wrapItemWidgetWithSelection(Widget child, bool isSelected) {
    if (!isSelected) {
      return child;
    }

    return Row(
      children: [
        Expanded(child: child),
        SizedBox(width: DraftModeUIStylePadding.tertiary),
        Icon(
          DraftModeUIButtons.checked,
          size: DraftModeUIStyleIconSize.large,
        ),
        SizedBox(width: DraftModeUIStylePadding.tertiary),
      ],
    );
  }
}
