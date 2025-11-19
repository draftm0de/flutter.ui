import 'package:draftmode_ui/components.dart';
import 'package:draftmode_ui/pages.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<int, String> map = {1: "Hallo", 2: "Welt", 4: "Example"};
    final items = DraftModeListItemBuilder.fromMap(map);
    final selectedItem = DraftModeListItem(id: 3, value: "UIList");
    items.add(selectedItem);

    final List<Widget> children = [
      DraftModeUISection(
        header: 'Basics',
        children: [
          DraftModeUIRow(const Text('Untitled note')),
          DraftModeUIRow(
            Text('Save to DraftMode'),
            label: 'Destination',
          ),
        ],
      ),
      const SizedBox(height: 24),
      DraftModeUISection(
        header: 'Custom label width',
        labelWidth: 120,
        children: [
          DraftModeUIRow(const Text('Auto')),
          DraftModeUIRow(
            Text('19.04.2024'),
            label: 'Created',
          ),
        ],
      ),
      DraftModeUISection(header: 'Custom label width', children: [
        DraftModeUIList(
          items: items,
          selectedItem: selectedItem,
          itemBuilder: (item, isSelected) {
            return Text(item.value);
          },
          onTap: (item) {
            debugPrint("pressedOnTab#${item.id}");
          },
        )
      ]),
    ];

    return DraftModeUIPageExample(title: 'DraftMode UI', children: children);
  }
}
