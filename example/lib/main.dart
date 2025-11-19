import 'package:draftmode_ui/styles.dart';
import 'package:flutter/widgets.dart';

import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DraftModeUIStyles.labelWidth = 135;
  runApp(App(navigatorKey: GlobalKey<NavigatorState>()));
}
