import '../database/app_database.dart';
import '../utilities/date_utils.dart';

class ProgressSnapshot {
  ProgressSnapshot({
    required this.dayNumber,
    required this.totalDays,
    required this.consistencyScore,
    required this.achievementScore,
    required this.completedTasksToday,
    required this.totalTasksToday,
    required this.completedBlocksToday,
    required this.totalBlocksToday,
    required this.roadmapState,
  });

  final int dayNumber;
  final int totalDays;
  final double consistencyScore;
  final double achievementScore;
  final int completedTasksToday;
  final int totalTasksToday;
  final int completedBlocksToday;
  final int totalBlocksToday;
  final String roadmapState; // not_started | active | completed
}

class ProgressService {
  ProgressService(this.db);
  final AppDatabase db;

  Future<ProgressSnapshot> snapshot([DateTime? now]) async {
    final today = LevelUpDateUtils.formatDate(now ?? DateTime.now());
    final day = LevelUpDateUtils.dayNumber(now);
    String state;
    if (LevelUpDateUtils.isBeforeRoadmap(now)) {
      state = 'not_started';
    } else if (LevelUpDateUtils.isAfterRoadmap(now)) {
      state = 'completed';
    } else {
      state = 'active';
    }

    final tasks = await (db.select(db.tasks)..where((t) => t.date.equals(today))).get();
    final blocks =
        await (db.select(db.scheduleBlocks)..where((t) => t.date.equals(today))).get();

    final completedTasks =
        tasks.where((t) => t.status == 'completed').length;
    final completedBlocks =
        blocks.where((t) => t.status == 'completed').length;

    final allTasks = await db.select(db.tasks).get();
    final allBlocks = await db.select(db.scheduleBlocks).get();
    final completedAllTasks =
        allTasks.where((t) => t.status == 'completed').length;
    final completedAllBlocks =
        allBlocks.where((t) => t.status == 'completed').length;

    final denom = (allTasks.length + allBlocks.length).clamp(1, 999999);
    final consistency =
        ((completedAllTasks + completedAllBlocks) / denom) * 100.0;

    final achievements = await db.select(db.achievements).get();
    final unlocked = achievements.where((a) => a.unlocked).length;
    final achievementScore = achievements.isEmpty
        ? 0.0
        : (unlocked / achievements.length) * 100.0;

    return ProgressSnapshot(
      dayNumber: day,
      totalDays: 365,
      consistencyScore: consistency.clamp(0, 100),
      achievementScore: achievementScore.clamp(0, 100),
      completedTasksToday: completedTasks,
      totalTasksToday: tasks.length,
      completedBlocksToday: completedBlocks,
      totalBlocksToday: blocks.length,
      roadmapState: state,
    );
  }
}
