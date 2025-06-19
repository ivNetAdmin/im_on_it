import 'package:im_on_it/data/entities/task_entity.dart';
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
    try{
    return Result.ok(await _taskService.getTaskList());
    } catch (error) {
    return Result.error(error as Exception);
    }
  }

  @override
  Future<Result<int>> addNewTask(TaskEntity newTask) async {
    try{
      int rowId = await _taskService.addNewTask(newTask);
      return Result.ok(rowId);
    } catch (error) {
      return Result.error(error as Exception);
    }
  }
}
