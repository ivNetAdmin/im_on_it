import 'package:flutter/material.dart';

import '../../data/repository/task_repository_interface.dart';
import '../../domain/models/task.dart';
import '../../utils/command.dart';
import '../../utils/result.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({
    required TaskRepositoryInterface taskRepository,
  }) : _taskRepository = taskRepository {
    loadCmd = Command0(_load)
      ..execute();
  }

  final TaskRepositoryInterface _taskRepository;

  late Command0 loadCmd;

  get load => _load();

  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<Result> _load() async {
    try {
      final result = await _taskRepository.getTaskList();
      switch (result) {
        case Ok<List<Task>>():
          _tasks = setDisplayOrder(result.value);
        case Error<List<Task>>():
          var err = result.error;
      }
      return result;
    } finally {
      notifyListeners();
    }
  }

  List<Task> setDisplayOrder(List<Task> tasks) {
    tasks = removeLapsedTasks(tasks);

    tasks.sort((b, a) {
      return a.displayOrder.compareTo(b.displayOrder);
    });
    return tasks;
  }

  List<Task> removeLapsedTasks(List<Task> tasks) {
    List<Task> cleanList = [];

    for (var i = 0; i < tasks.length; i++) {
      if (tasks[i].displayTimeLapsed() > 100) {
        if (tasks[i].type == 'yes_dear') {
          cleanList.add(tasks[i]);
        }
      } else {
        cleanList.add(tasks[i]);
      }
    }
    return cleanList;
  }
}