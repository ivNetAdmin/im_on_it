import 'package:im_on_it/utils/result.dart';

import '../../entities/task_entity.dart';
import '../../services/task_service_interface.dart';
import '../task_repository_interface.dart';

class TaskRepository implements TaskRepositoryInterface {

  TaskRepository({
    required TaskServiceInterface taskService,
  }) : _taskService = taskService;

  final TaskServiceInterface _taskService;

  @override
  Future<Result<List<TaskEntity>>> getTaskList() async {
    try {
      return Result.ok(await _taskService.getTaskList());
    } on Error catch (error) {
      return Result.error(error as Exception);
    }
  }

  @override
  Future<Result<int>> addNewTask(TaskEntity newTask) async {
    if (newTask.description == 'deleteDb') {
      await _taskService.deleteDb();
      return Result.ok(0);
    }

    try {
      int rowId = await _taskService.addNewTask(newTask);
      return Result.ok(rowId);
    } on Exception catch (exception) {
      return Result.error(exception);
    }
  }

  @override
  Future<Result<int>> completeTask(TaskEntity task) async {
    try {
      int rowId = 0;
      // add completed task to completedTask repository

      if(task.repeat==1) {
        //if task is repeat then update last completed date for current task
        rowId = await _taskService.updateTask(task);
      }else{
        // if task is not repeat then then delete the current task
        rowId = await _taskService.deleteTask(task);
      }

      return Result.ok(rowId);
    } on Exception catch (exception) {
      return Result.error(exception);
    }
  }

  @override
  Future<Result<int>> deleteTask(TaskEntity task) async {
    try {
      int rowId = await _taskService.deleteTask(task);
      return Result.ok(rowId);
    } on Exception catch (exception) {
      return Result.error(exception);
    }
  }
}