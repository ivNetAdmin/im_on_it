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
    try {
      int rowId = await _taskService.addNewTask(newTask);
      return Result.ok(rowId);
    } on Exception catch (exception) {
      return Result.error(exception);
    }
  }
}