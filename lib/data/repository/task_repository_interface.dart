
import '../../utils/result.dart';
import '../entities/task_entity.dart';
import '../entities/task_history_entity.dart';

abstract class TaskRepositoryInterface{
  Future<Result<List<TaskEntity>>> getTaskList();
  Future<Result<TaskEntity>> getTask(int taskId);

  Future<Result<int>> rescheduleTask(int taskId);

  Future<Result<int>>addNewTask(TaskEntity newTask);
  Future<Result<int>>completeTask(int taskId);
  Future<Result<int>>deleteTask(TaskEntity task);

  Future<Result<List<TaskHistoryEntity>>> getTaskHistoryList();

}