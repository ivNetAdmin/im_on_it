import 'package:im_on_it/data/entities/task_entity.dart';

import '../task_service_interface.dart';
import 'database_helper.dart';

class TaskService implements TaskServiceInterface {

  @override
  Future<List<TaskEntity>> getTaskList() async {
    final tasks = List<TaskEntity>.empty(growable: true);

    List<Map<String, dynamic>> entityList = await DatabaseHelper.getAllTask();

    for (final entity in entityList) {
      tasks.add(TaskEntity.fromJson(entity));
    }
    return tasks;
  }

  @override
  Future<TaskEntity> getTask(int taskId) async {
    Map<String, Object?> entity = await DatabaseHelper.getTask(taskId);

    return TaskEntity.fromJson(entity);
  }

  @override
  Future<int> addNewTask(TaskEntity newTask) async {
    return await DatabaseHelper.addTask(newTask.toJson());
  }

  @override
  Future<int> updateTask(TaskEntity task) async {
    return await DatabaseHelper.updateTask(task.toJson(), task.id ?? 0);
  }

  @override
  Future<int> deleteTask(TaskEntity task) async {
    return await DatabaseHelper.deleteTask(task.id ?? 0);
  }

  @override
  Future<void> deleteDb() async {
    DatabaseHelper.deleteDb();
  }
}