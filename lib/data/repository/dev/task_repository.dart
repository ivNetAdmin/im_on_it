import 'dart:convert';

import 'package:im_on_it/domain/models/task.dart';
import 'package:im_on_it/utils/result.dart';

import '../../services/task_service_interface.dart';
import '../task_repository_interface.dart';

class TaskRepository implements TaskRepositoryInterface {

  TaskRepository({
    required TaskServiceInterface taskService,
  }) : _taskService = taskService;

  final TaskServiceInterface _taskService;

  @override
  Future<Result<List<Task>>> getTaskList() async {

    List<Task> tasks = [];

    var result = await _taskService.getTaskListJson();

    switch (result) {
      case Ok(): {

        var taskArray = jsonDecode(result.value) as List;

        for (var i = 0; i < taskArray.length; i++) {
          var task = Task.fromJson(taskArray[0]);
          tasks.add(task);
        }

        return Result.ok(tasks);

      }
      case Error(): {
        return Result.error(Exception(result.error));
      }
    }


  }
}