import 'package:draftmode_ui/styles.dart';
import 'package:draftmode_ui/context.dart';
import 'package:flutter/widgets.dart';

import 'app.dart';

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DraftModeUIStyles.labelWidth = 135;
  DraftModeUIContext.init(navigatorKey: _navigatorKey);
  runApp(App(navigatorKey: _navigatorKey));
}
