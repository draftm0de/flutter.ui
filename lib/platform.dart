import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform;

class DraftModeUIPlatform {
  static bool get isIOS => defaultTargetPlatform == TargetPlatform.iOS;
}
