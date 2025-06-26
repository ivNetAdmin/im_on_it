
import '../entities/task_entity.dart';

abstract class TaskServiceInterface {
  Future<List<TaskEntity>> getTaskList();
  Future<int>addNewTask(TaskEntity newTask);
  Future<int>deleteTask(TaskEntity task);
  Future<void> deleteDb();
}