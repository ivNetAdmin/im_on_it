import 'package:im_on_it/data/entities/task_entity.dart';
import 'package:im_on_it/data/entities/task_history_entity.dart';
import 'package:im_on_it/data/repository/task_repository_interface.dart';
import 'package:im_on_it/data/services/task_service_interface.dart';
import 'package:im_on_it/utils/result.dart';

class FakeTaskRepository implements TaskRepositoryInterface {

  FakeTaskRepository({
    required TaskServiceInterface taskService,
  }) : _taskService = taskService;

  final TaskServiceInterface _taskService;

  @override
  Future<Result<List<TaskEntity>>> getTaskList() async {
    try {
      return Result.ok(await _taskService.getTaskList());
    } catch (error) {
      return Result.error(error as Exception);
    }
  }

  @override
  Future<Result<int>> addNewTask(TaskEntity newTask) async {
    try {
      int rowId = await _taskService.addNewTask(newTask);
      return Result.ok(rowId);
    } catch (error) {
      return Result.error(error as Exception);
    }
  }

  @override
  Future<Result<int>> deleteTask(TaskEntity task) async {
    try {
      int rowId = await _taskService.deleteTask(task);
      return Result.ok(rowId);
    } catch (error) {
      return Result.error(error as Exception);
    }
  }

  @override
  Future<Result<int>> completeTask(int taskId) async {
    try {
      List<TaskEntity> tasks = await _taskService.getTaskList();

      for (var i = 0; i < tasks.length; i++) {
        if (tasks[i].id == taskId) {
          TaskEntity updatedTask = TaskEntity(
            id: tasks[0].id,
            description: tasks[0].description,
            createDate: tasks[0].createDate,
            lastCompletedDate: DateTime
                .now()
                .microsecondsSinceEpoch,
            type: tasks[0].type,
            timeSpan: tasks[0].timeSpan,
            timePeriod: tasks[0].timePeriod,
            repeat: tasks[0].repeat,
          );

          tasks[i] = updatedTask;
        }
      }
      return Result.ok(taskId);
    } catch (error) {
      return Result.error(error as Exception);
    }
  }

  @override
  Future<Result<List<TaskHistoryEntity>>> getTaskHistoryList() {
    // TODO: implement getCompletedTaskList
    throw UnimplementedError();
  }
}
