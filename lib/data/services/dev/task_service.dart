import 'dart:convert';

import '../../../domain/models/task.dart';
import '../../../utils/create_task_list.dart';
import '../../../utils/result.dart';
import '../task_service_interface.dart';

class TaskService implements TaskServiceInterface {

  List<Task> _tasks = List<Task>.empty(growable: true);

  TaskService() {
    _tasks = createTaskList();
  }

  @override
  Future<Result<String>> getTaskListJson() async {
    try {
      return Result.ok(jsonEncode(_tasks.map((e) => e.toJson()).toList()));
    } on Exception catch (exception)
    {
      return Result.error(exception);
    }
  }
 }