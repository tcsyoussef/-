import 'constants.dart';

class LevelUpDateUtils {
  LevelUpDateUtils._();

  static DateTime dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  static String formatDate(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';

  static DateTime parseDate(String s) {
    final parts = s.split('-');
    return DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );
  }

  /// 1-based day counter relative to roadmap start (device-local date).
  static int dayNumber([DateTime? now]) {
    final today = dateOnly(now ?? DateTime.now());
    final start = dateOnly(LevelUpConstants.roadmapStart);
    final end = dateOnly(LevelUpConstants.roadmapEnd);
    if (today.isBefore(start)) return 0;
    if (today.isAfter(end)) return LevelUpConstants.totalDays;
    return today.difference(start).inDays + 1;
  }

  static bool isWithinRoadmap([DateTime? now]) {
    final today = dateOnly(now ?? DateTime.now());
    final start = dateOnly(LevelUpConstants.roadmapStart);
    final end = dateOnly(LevelUpConstants.roadmapEnd);
    return !today.isBefore(start) && !today.isAfter(end);
  }

  static bool isBeforeRoadmap([DateTime? now]) =>
      dateOnly(now ?? DateTime.now())
          .isBefore(dateOnly(LevelUpConstants.roadmapStart));

  static bool isAfterRoadmap([DateTime? now]) =>
      dateOnly(now ?? DateTime.now())
          .isAfter(dateOnly(LevelUpConstants.roadmapEnd));

  static bool isSunday([DateTime? now]) =>
      (now ?? DateTime.now()).weekday == DateTime.sunday;

  static int monthIndex(DateTime date) {
    final start = dateOnly(LevelUpConstants.roadmapStart);
    final d = dateOnly(date);
    if (d.isBefore(start)) return 0;
    final months =
        (d.year - start.year) * 12 + (d.month - start.month);
    return months.clamp(0, 11);
  }

  static int quarterIndex(DateTime date) => monthIndex(date) ~/ 3;

  static String weekdayName(int weekday) {
    const names = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return names[weekday - 1];
  }

  static String fitnessPlanForWeekday(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Upper A + Abs';
      case DateTime.tuesday:
        return 'Lower A + Posture';
      case DateTime.wednesday:
        return 'Walk + Mobility';
      case DateTime.thursday:
        return 'Upper B + Abs';
      case DateTime.friday:
        return 'Lower B + Posture';
      case DateTime.saturday:
        return 'Walk + Core + Mobility';
      case DateTime.sunday:
        return 'Recovery';
      default:
        return 'Rest';
    }
  }
}
