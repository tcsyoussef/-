import 'package:flutter_test/flutter_test.dart';
import 'package:level_up/utilities/constants.dart';

void main() {
  test('LEVEL UP constants are configured', () {
    expect(LevelUpConstants.appName, 'LEVEL UP');
    expect(LevelUpConstants.totalDays, 365);
    expect(LevelUpConstants.roadmapStart, DateTime(2026, 11, 27));
  });
}
