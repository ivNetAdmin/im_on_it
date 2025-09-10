import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = 'ImOnIt.db';

  static const String _dbTaskTableSql = 'CREATE TABLE Task('
      'id INTEGER PRIMARY KEY,'
      'description TEXT NOT NULL,'
      'createDate INTEGER NOT NULL,'
      'lastCompletedDate INTEGER NOT NULL,'
      'type TEXT NOT NULL,'
      'timeSpan TEXT NOT NULL,'
      'timePeriod TEXT NOT NULL,'
      'repeat INTEGER NOT NULL'
      ');';

  static const String _dbTaskHistoryTableSql = 'CREATE TABLE TaskHistory('
      'id INTEGER PRIMARY KEY,'
      'taskId INTEGER NOT NULL,'
      'description TEXT NOT NULL,'
      'createDate INTEGER NOT NULL,'
      'lastCompletedDate INTEGER NOT NULL,'
      'type TEXT NOT NULL,'
      'timeSpan TEXT NOT NULL,'
      'timePeriod TEXT NOT NULL,'
      'repeat INTEGER NOT NULL,'
      'lapsed INTEGER NOT NULL'
      ');';

  static Future<Database> _getDb() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) {
        db.execute(_dbTaskTableSql);
        return db.execute(_dbTaskHistoryTableSql);
      },
      // Set the version. This runs the onCreate function and provides a
      // path to perform updates and downgrades on the database.
      version: _version,);
  }

  static void deleteDb() async {
    databaseFactory.deleteDatabase(join(await getDatabasesPath(), _dbName));
  }

  static Future<int> addTask(Map<String, dynamic> task) async {
    final db = await _getDb();
    return await db.insert("Task", task,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateTask(Map<String, dynamic> task, int id) async {
    final db = await _getDb();
    return await db.update("Task", task,
        where: 'id = ?',
        whereArgs: [id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteTask(int id) async {
    final db = await _getDb();
    return await db.delete("Task",
        where: 'id = ?',
        whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> getAllTask() async {
    final db = await _getDb();

    return await db.query("Task");
  }

  static Future<Map<String, Object?>> getTask(int taskId) async {
    final db = await _getDb();
    final rows = await db.query("Task",
        where: 'id = ?',
        whereArgs: [taskId]);
    if (rows.isNotEmpty) {
      return rows.first;
    }else{
      throw UnsupportedError('Task entity not found [$taskId]');
    }
  }

  static Future<List<Map<String, dynamic>>> getAllTaskHistory() async {
    final db = await _getDb();

    return await db.query("TaskHistory");
  }

  static Future<int> addTaskHistory(Map<String, dynamic> taskHistory) async {
    final db = await _getDb();
    return await db.insert("TaskHistory", taskHistory,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<Map<String, Object?>> getTaskHistoryEntityByTaskId(int taskId) async {
    final db = await _getDb();
    final rows = await db.query("TaskHistory",
        where: 'taskId = ?',
        whereArgs: [taskId]);
    if (rows.isNotEmpty) {
      return rows.first;
    }else{
      throw UnsupportedError('TaskHistory entity not found [$taskId]');
    }
  }
}