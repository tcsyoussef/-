import 'package:flutter_test/flutter_test.dart';
import 'package:level_up/utilities/date_utils.dart';

void main() {
  group('LevelUpDateUtils.dayNumber', () {
    test('returns 0 before roadmap', () {
      expect(LevelUpDateUtils.dayNumber(DateTime(2026, 11, 26)), 0);
    });

    test('returns 1 on Day 1', () {
      expect(LevelUpDateUtils.dayNumber(DateTime(2026, 11, 27)), 1);
    });

    test('returns 365 on final day', () {
      expect(LevelUpDateUtils.dayNumber(DateTime(2027, 11, 26)), 365);
    });

    test('returns 365 after roadmap', () {
      expect(LevelUpDateUtils.dayNumber(DateTime(2027, 11, 27)), 365);
    });
  });

  test('format/parse roundtrip', () {
    final d = DateTime(2026, 11, 27);
    expect(LevelUpDateUtils.parseDate(LevelUpDateUtils.formatDate(d)), d);
  });

  test('fitness plan Monday is Upper A', () {
    expect(LevelUpDateUtils.fitnessPlanForWeekday(DateTime.monday),
        'Upper A + Abs');
  });
}
