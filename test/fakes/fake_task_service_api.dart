
import 'dart:convert';

import 'package:im_on_it/data/services/task_service_interface.dart';
import 'package:im_on_it/domain/models/task.dart';

DateTime _now = DateTime.utc(2025, 01, 23);

class FakeTaskServiceAPI implements TaskServiceInterface {

  int _sequentialId = 0;
  final _tasks = List<Task>.empty(growable: true);

  FakeTaskServiceAPI() {
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
          createDate: _now, //  (2025, 1, 6),
        ),
      );

      _tasks.add(
        Task(
          id: _sequentialId++,
          description: 'My next task!',
          createDate: _now, //  (2025, 1, 6),
        ),
      );

      _tasks.add(
        Task(
          id: _sequentialId++,
          description: 'My next next task!',
          createDate: _now, //  (2025, 1, 6),
        ),
      );
    }
  }
}