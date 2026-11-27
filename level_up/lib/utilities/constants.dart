/// LEVEL UP roadmap and personal defaults.
class LevelUpConstants {
  LevelUpConstants._();

  static const String appName = 'LEVEL UP';
  static const String backupVersion = '1.0.0';

  static final DateTime roadmapStart = DateTime(2026, 11, 27);
  static final DateTime roadmapEnd = DateTime(2027, 11, 26);
  static const int totalDays = 365;

  static const String wakeUpDefault = '12:00';
  static const String sleepDefault = '04:00';
  static const int dailyDevMinutes = 360;
  static const String trainingLocation = 'Home';
  static const String currency = 'MAD';
  static const String language = 'English';

  static const List<String> goalIds = [
    'fitness',
    'english',
    'repair',
    'appearance',
  ];

  static const Map<String, String> goalTitles = {
    'fitness': 'Fitness',
    'english': 'English',
    'repair': 'Repair Academy',
    'appearance': 'Appearance',
  };

  static const Map<String, int> defaultDailyMinutes = {
    'fitness': 60,
    'english': 120,
    'repair': 150,
    'appearance': 30,
  };
}
