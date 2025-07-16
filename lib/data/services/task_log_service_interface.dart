import '../entities/task_entity_log.dart';

abstract class TaskLogServiceInterface {
  Future<List<TaskEntityLog>> getTaskLogList();
  Future<int>addNewTaskLog(TaskEntityLog newTaskLog);
}