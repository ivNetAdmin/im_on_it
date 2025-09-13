import 'package:im_on_it/data/entities/task_history_entity.dart';

import '../../../domain/models/task_history.dart';
import '../task_history_service_interface.dart';
import 'database_helper.dart';

class TaskHistoryService implements TaskHistoryServiceInterface {
  @override
  Future<int> addNewTaskHistory(TaskHistoryEntity newTaskHistory) async {
    return await DatabaseHelper.addTaskHistory(newTaskHistory.toJson());
  }

  @override
  Future<List<TaskHistoryEntity>> getAllTaskHistory() async {
    final taskHistoryList = List<TaskHistoryEntity>.empty(growable: true);

    List<Map<String, dynamic>> entityList = await DatabaseHelper.getAllTaskHistory();

    for (final entity in entityList) {
      taskHistoryList.add(TaskHistoryEntity.fromJson(entity));
    }
    return taskHistoryList;
  }

  @override
  Future<TaskHistoryEntity> getTaskHistoryEntityByTaskId(int taskId) async {
    try{
      Map<String, Object?> entity = await DatabaseHelper.getTaskHistoryEntityByTaskId(taskId);
      return TaskHistoryEntity.fromJson(entity);
    } on Error catch (error) {
      throw Exception(error.toString());
    }
  }

  @override
  Future<int> deleteTaskHistory(TaskHistory taskHistory) async {
    return await DatabaseHelper.deleteHistoryTask(taskHistory.id ?? 0);
  }

}