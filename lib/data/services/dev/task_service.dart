import 'dart:convert';

import '../../../domain/models/task.dart';
import '../../../utils/result.dart';
import '../task_service_interface.dart';

class TaskService implements TaskServiceInterface {

  int _sequentialId = 0;
  final _tasks = List<Task>.empty(growable: true);

  TaskService() {
    _createTaskList();
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

  Future<void> _createTaskList() async {
    if (_tasks.isEmpty) {
      _tasks.add(
        Task(
          id: _sequentialId++,
          description: 'My first task!',
          createDate: DateTime.now(), //  (2025, 1, 6),
        ),
      );

      _tasks.add(
        Task(
          id: _sequentialId++,
          description: 'My next task!',
          createDate: DateTime.now(), //  (2025, 1, 6),
        ),
      );

      _tasks.add(
        Task(
          id: _sequentialId++,
          description: 'My next next task!',
          createDate: DateTime.now(), //  (2025, 1, 6),
        ),
      );
    }
  }
}