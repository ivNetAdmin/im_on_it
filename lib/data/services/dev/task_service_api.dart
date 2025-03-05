import 'dart:convert';

import '../../../domain/models/task.dart';
import '../task_service.dart';

class TaskServiceAPI implements TaskService {

  int _sequentialId = 0;
  final _tasks = List<Task>.empty(growable: true);

  TaskServiceAPI() {
    _createTaskList();
  }

  @override
  Future<String> getTaskListJson() async {
    return jsonEncode(_tasks.map((e) => e.toJson()).toList());
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