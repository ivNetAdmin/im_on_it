import 'package:im_on_it/data/repository/task_repository_interface.dart';
import 'package:im_on_it/domain/models/task.dart';
import 'package:im_on_it/utils/result.dart';

import '../utils/create_task_list.dart';

class FakeTaskRepository implements TaskRepositoryInterface {

  @override
  Future<Result<List<Task>>> getTaskList() async {
    final tasks = createTaskList();
    return Result.ok(tasks);
  }
}