import 'package:draftmode_ui/context.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  tearDown(DraftModeUIContext.debugReset);

  test('init throws when neither navigator nor context provided', () {
    expect(() => DraftModeUIContext.init(), throwsArgumentError);
  });
}
