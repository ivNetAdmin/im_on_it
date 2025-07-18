import 'package:im_on_it/utils/result.dart';

import '../../entities/task_entity.dart';
import '../../entities/task_entity_log.dart';
import '../../services/task_log_service_interface.dart';
import '../../services/task_service_interface.dart';
import '../task_repository_interface.dart';

class TaskRepository implements TaskRepositoryInterface {

  TaskRepository({
    required TaskServiceInterface taskService,
    required TaskLogServiceInterface taskLogService,
  }) : _taskService = taskService, _taskLogService = taskLogService;

  final TaskServiceInterface _taskService;
  final TaskLogServiceInterface _taskLogService;

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
      // add completed task to taskLog repository
      TaskEntityLog taskEntityLog = TaskEntityLog(
        id: task.id,
        description: '${task.description} [${task.type} ${task.timePeriod} ${task.repeat == 0 ? 'no-repeat' : 'repeat'}]',  //'My first task! [fun d3 no-repeat]',
        lastCompletedDate: task.lastCompletedDate,
        lapsed: 0,
      );

      rowId = await _taskLogService.addNewTaskLog(taskEntityLog);

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