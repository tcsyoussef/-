import 'package:flutter_test/flutter_test.dart';
import 'package:level_up/utilities/constants.dart';

void main() {
  test('constants identity', () {
    expect(LevelUpConstants.appName, 'LEVEL UP');
    expect(LevelUpConstants.totalDays, 365);
    expect(LevelUpConstants.goalIds, hasLength(4));
  });
}
