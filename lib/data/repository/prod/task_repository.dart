import 'package:im_on_it/utils/result.dart';

import '../../../ui/home/helpers/date_format_helper.dart';
import '../../../ui/home/helpers/home_view_model_helper.dart';
import '../../entities/task_entity.dart';
import '../../entities/task_history_entity.dart';
import '../../services/task_history_service_interface.dart';
import '../../services/task_service_interface.dart';
import '../task_repository_interface.dart';

class TaskRepository implements TaskRepositoryInterface {

  TaskRepository({
    required TaskServiceInterface taskService,
    required TaskHistoryServiceInterface taskHistoryService,
  })
      : _taskService = taskService,
        _taskHistoryService = taskHistoryService;

  final TaskServiceInterface _taskService;
  final TaskHistoryServiceInterface _taskHistoryService;

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
  Future<Result<int>> completeTask(int taskId) async {
    try {
      int rowId = 0;
      int now = DateFormatHelper.fromDate(DateTime.now());

      TaskEntity task = await _taskService.getTask(taskId);

      // add completed task to taskLog repository
      TaskHistoryEntity taskEntityHistory = HomeViewModelHelper
          .setNewTaskHistoryEntityDate(task, now);

      rowId = await _taskHistoryService.addNewTaskHistory(taskEntityHistory);

      // add completed task to taskLog repository
      TaskEntity taskEntity = HomeViewModelHelper.setNewTaskEntityDate(
          task, now);

      if (task.repeat == 1) {
        //if task is repeat then update last completed date for current task
        rowId = await _taskService.updateTask(taskEntity);
      } else {
        // if task is not repeat then then delete the current task
        rowId = await _taskService.deleteTask(taskEntity);
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

  @override
  Future<Result<List<TaskHistoryEntity>>> getTaskHistoryList() async {
    try {
      return Result.ok(await _taskHistoryService.getAllTaskHistory());
    } on Error catch (error) {
      return Result.error(error as Exception);
    }
  }
}