import 'package:drift/drift.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../database/app_database.dart';

class NotificationService {
  NotificationService(this.db);

  final AppDatabase db;
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;
  bool permissionGranted = false;

  Future<void> init() async {
    if (_initialized) return;
    tzdata.initializeTimeZones();
    try {
      final name = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(name));
    } catch (_) {
      tz.setLocalLocation(tz.getLocation('UTC'));
    }

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: android);
    await _plugin.initialize(initSettings);

    final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    permissionGranted =
        await androidPlugin?.requestNotificationsPermission() ?? false;

    final settings = await db.select(db.appSettings).getSingleOrNull();
    if (settings != null) {
      await (db.update(db.appSettings)..where((t) => t.id.equals(settings.id)))
          .write(AppSettingsCompanion(
        notificationPermissionGranted: Value(permissionGranted),
      ));
    }

    _initialized = true;
  }

  Future<void> syncFromPrefs() async {
    await init();
    await _plugin.cancelAll();

    final settings = await db.select(db.appSettings).getSingleOrNull();
    if (settings == null || !settings.notificationsEnabled) return;
    if (!permissionGranted) return;

    final prefs = await db.select(db.notificationPrefs).get();
    var id = 100;
    for (final pref in prefs) {
      if (!pref.enabled) continue;
      await _scheduleDaily(id++, pref.title, pref.body, pref.timeHhMm);
    }
  }

  Future<void> _scheduleDaily(
    int id,
    String title,
    String body,
    String hhMm,
  ) async {
    final parts = hhMm.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      scheduled,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'level_up_reminders',
          'LEVEL UP Reminders',
          channelDescription: 'Daily schedule reminders for LEVEL UP',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
