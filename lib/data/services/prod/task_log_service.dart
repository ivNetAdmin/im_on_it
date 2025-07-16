import 'package:im_on_it/data/entities/task_entity_log.dart';

import '../task_log_service_interface.dart';
import 'database_helper.dart';

class TaskLogService implements TaskLogServiceInterface {
  @override
  Future<int> addNewTaskLog(TaskEntityLog newTaskLog) async {
    return await DatabaseHelper.addTaskLog(newTaskLog.toJson());
  }

  @override
  Future<List<TaskEntityLog>> getTaskLogList() async {
    final taskLogs = List<TaskEntityLog>.empty(growable: true);

    List<Map<String, dynamic>> entityList = await DatabaseHelper.getAllTaskLog();

    for (final entity in entityList) {
      taskLogs.add(TaskEntityLog.fromJson(entity));
    }
    return taskLogs;
  }

}