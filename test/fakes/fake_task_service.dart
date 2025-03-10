
import 'dart:convert';

import 'package:im_on_it/data/services/task_service_interface.dart';
import 'package:im_on_it/utils/result.dart';

import '../utils/create_task_list.dart';

class FakeTaskService implements TaskServiceInterface {

  final _tasks = createTaskList();

  @override
  Future<Result<String>> getTaskListJson() async {
      return Result.ok(jsonEncode(_tasks.map((e) => e.toJson()).toList()));
  }
}