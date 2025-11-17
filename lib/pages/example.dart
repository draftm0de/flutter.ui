import 'package:draftmode_ui/pages/page.dart';
import 'package:flutter/cupertino.dart';

class DraftModeUIPageExample extends StatelessWidget {
  const DraftModeUIPageExample({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DraftModeUIPage(
        containerBackgroundColor: CupertinoColors.white,
        navigationTitle: title,
        horizontalContainerPadding: 0,
        verticalContainerPadding: 0,
        topLeading: null,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _HeaderCard(),
            const SizedBox(height: 40),
            ...children,
          ],
        ));
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: CupertinoColors.systemGrey, width: 0.8),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          // Include package name so the asset resolves when this widget ships as a dependency.
          Image.asset(
            'assets/images/logo.png',
            package: 'draftmode_ui',
            height: 70,
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DraftMode',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4),
                Text(
                  'Development is infinite\n...like your mind',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
