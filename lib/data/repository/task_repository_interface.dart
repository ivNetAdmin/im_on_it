
import '../../utils/result.dart';
import '../entities/task_entity.dart';

abstract class TaskRepositoryInterface{
  Future<Result<List<TaskEntity>>> getTaskList();
  Future<Result<int>>addNewTask(TaskEntity newTask);
  Future<Result<int>>completeTask(TaskEntity task);
  Future<Result<int>>deleteTask(TaskEntity task);
}