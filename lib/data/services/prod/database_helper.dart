import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = 'ImOnIt.db';

  static const String _taskTableSql = 'CREATE TABLE Task('
      'id INTEGER PRIMARY KEY,'
      'description TEXT NOT NULL,'
      'createDate INTEGER NOT NULL,'
      'lastCompletedDate INTEGER NOT NULL,'
      'type TEXT NOT NULL,'
      'timeSpan TEXT NOT NULL,'
      'timePeriod TEXT NOT NULL,'
      'repeat INTEGER NOT NULL'
      ');';

  static Future<Database> _getDb() async {

    //databaseFactory.deleteDatabase(join(await getDatabasesPath(), _dbName));

    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async =>
        await db.execute(_taskTableSql),
        version: _version
    );
  }

  static Future<int> addTask(Map<String, dynamic> task) async {
    final db = await _getDb();
    return await db.insert("Task", task,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateTask(Map<String, dynamic> task, String id) async {
    final db = await _getDb();
    return await db.update("Task", task,
        where: 'id = ?',
        whereArgs: [id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteTask(Map<String, dynamic> task, String id) async {
    final db = await _getDb();
    return await db.delete("Task",
        where: 'id = ?',
        whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> getAllTask() async {
    final db = await _getDb();

    return await db.query("Task");
  }
}