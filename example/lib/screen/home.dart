import 'package:draftmode_ui/components.dart';
import 'package:draftmode_ui/pages.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final List<DraftModeListItem> _items;
  DraftModeListItem? _selectedItem;
  bool _switch = false;

  @override
  void initState() {
    super.initState();
    final Map<int, String> map = {1: 'Hallo', 2: 'Welt', 3: 'Example'};
    _items = DraftModeListItemBuilder.fromMap(map);
    _selectedItem = _items.first;
    _switch = false;
  }

  Future<void> _showDialog(BuildContext context) async {
    await DraftModeUIDialog.show(
      title: 'Title',
      message: 'Message',
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      DraftModeUISection(
        header: 'Basic Section',
        children: [
          DraftModeUIRow(const Text('Untitled note')),
          DraftModeUIRow(
            Text('Save to DraftMode'),
            label: 'Destination',
          ),
          DraftModeUIRow(
            DraftModeUISwitch(
              value: _switch,
              onChanged: (value) {
                setState(() {
                  _switch = value;
                });
              },
            ),
            label: 'Switcher',
          )
        ],
      ),
      DraftModeUISection(
        header: 'Basic Section (label width: 90)',
        labelWidth: 90,
        children: [
          DraftModeUIRow(
            Text('19.04.2024'),
            label: 'Created',
          ),
        ],
      ),
      DraftModeUISection(header: 'List', children: [
        DraftModeUIList(
          isPending: (_items.isEmpty),
          items: _items,
          selectedItem: _selectedItem,
          itemBuilder: (item, isSelected) => Text(item.value.toString()),
          onTap: (item) => setState(() => _selectedItem = item),
        ),
      ]),
      DraftModeUISection(header: 'DropDown', children: [
        DraftModeUIDropDown(
          isPending: (_items.isEmpty),
          pageTitle: 'DropDown Page',
          items: _items,
          selectedItem: _selectedItem,
          emptyPlaceholder: const Text('Tap to pick an item'),
          itemBuilder: (item, isSelected) => Text(item.value.toString()),
          onChanged: (item) => setState(() => _selectedItem = item),
        ),
      ]),
      DraftModeUISection(header: 'Buttons', children: [
        DraftModeUIButton.text(
          'openDialog',
          onPressed: () => _showDialog(context),
        ),
      ]),
    ];

    return DraftModeUIPageExample(title: 'DraftMode UI', children: children);
  }
}
