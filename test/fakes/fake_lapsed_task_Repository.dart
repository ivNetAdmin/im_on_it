import 'package:flutter_guid/flutter_guid.dart';
import 'package:im_on_it/data/repository/task_repository_interface.dart';
import 'package:im_on_it/domain/models/task.dart';
import 'package:im_on_it/utils/result.dart';

class FakeLapsedTaskRepository implements TaskRepositoryInterface {

  @override
  Future<Result<List<Task>>> getTaskList() async {
    var lastCompletedDate = DateTime.now().subtract(Duration(days: 7));

    final tasks = List<Task>.empty(growable: true);

    tasks.add(
      Task(
        id: Guid("aaaaaaaa-aaaa-cccc-dddd-eeeeeeeeeeee").toString(),
        description: 'My first task!',
        createDate: lastCompletedDate,
        lastCompletedDate: lastCompletedDate,
        type: 'fun',
        timeSpan: 'd',
        timePeriod: 'd',
        repeat: false,
      ),
    );

    tasks.add(
      Task(
        id: Guid("aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee").toString(),
        description: 'My next task!',
        createDate: lastCompletedDate,
        lastCompletedDate: lastCompletedDate,
        type: 'chore',
        timeSpan: 'w',
        timePeriod: 'wd',
        repeat: true,
      ),
    );

    tasks.add(
      Task(
        id: Guid("aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee").toString(),
        description: 'My next task!',
        createDate: lastCompletedDate,
        lastCompletedDate: lastCompletedDate,
        type: 'yes_dear',
        timeSpan: 'd',
        timePeriod: 'wd',
        repeat: true,
      ),
    );

    return Result.ok(tasks);
  }
}