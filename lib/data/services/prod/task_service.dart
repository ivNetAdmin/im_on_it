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
  Future<int> addNewTask(TaskEntity newTask) async {
    return await DatabaseHelper.addTask(newTask.toJson());
  }

  @override
  Future<void> deleteDb() async {
    DatabaseHelper.deleteDb();
  }
}