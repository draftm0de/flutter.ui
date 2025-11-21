import 'package:draftmode_localization/localizations.dart';
import 'package:draftmode_ui_example/screen/home.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class App extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const App({
    super.key,
    required this.navigatorKey,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformProvider(
      builder: (context) => PlatformApp(
        navigatorKey: widget.navigatorKey,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: DraftModeLocalizations.localizationsDelegates,
        supportedLocales: DraftModeLocalizations.supportedLocales,
        material: (_, __) => MaterialAppData(color: const Color(0xFFFFFFFF)),
        cupertino: (_, __) => CupertinoAppData(),
        home: const HomeScreen(),
      ),
    );
  }
}
