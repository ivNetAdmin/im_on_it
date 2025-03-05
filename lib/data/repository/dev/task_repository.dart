import 'package:im_on_it/domain/models/task.dart';

import 'package:im_on_it/utils/result.dart';

import '../task_repository_interface.dart';

class TaskRepository implements TaskRepositoryInterface {

  @override
  Future<Result<List<Task>>> getTaskList() {
    // TODO: implement getTaskList
    throw UnimplementedError();
  }

}