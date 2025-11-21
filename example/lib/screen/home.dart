import 'package:draftmode_ui/components.dart';
import 'package:draftmode_ui/pages.dart';
import 'package:draftmode_ui/styles.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _showDialog(BuildContext context) async {
    await DraftModeUIDialog.show(
      title: 'Title',
      message: 'Message',
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<int, String> map = {1: "Hallo", 2: "Welt", 4: "Example"};
    final items = DraftModeListItemBuilder.fromMap(map);
    final selectedItem = DraftModeListItem(id: 3, value: "UIList");
    items.add(selectedItem);

    final List<Widget> children = [
      DraftModeUISection(
        header: 'Basic Section',
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
        header: 'Basic Section (custom label width)',
        labelWidth: 120,
        children: [
          DraftModeUIRow(const Text('Auto')),
          DraftModeUIRow(
            Text('19.04.2024'),
            label: 'Created',
          ),
        ],
      ),
      DraftModeUISection(header: 'List View', children: [
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
      DraftModeUISection(header: 'Buttons', children: [
        DraftModeUIButton(
          onPressed: () => _showDialog(context),
          child: Text('openDialog',
              style:
                  TextStyle(color: DraftModeUIStyleButtonColors.submit.font)),
        )
      ]),
    ];

    return DraftModeUIPageExample(title: 'DraftMode UI', children: children);
  }
}
