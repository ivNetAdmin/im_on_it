import 'dart:async';

import 'package:flutter/material.dart';

import '../../data/entities/task_history_entity.dart';
import '../../utils/command.dart';
import '../../data/repository/task_repository_interface.dart';
import '../../utils/result.dart';

class TaskHistoryViewModel extends ChangeNotifier {
  TaskHistoryViewModel({
    required TaskRepositoryInterface taskRepository,
  }) : _taskRepository = taskRepository {
    loadCmd = Command0(_load)
      ..execute();
  }

  final TaskRepositoryInterface _taskRepository;

  List<TaskHistoryEntity> _taskHistoryList = [];

  List<TaskHistoryEntity> get taskHistoryList => _taskHistoryList;

  late Command0 loadCmd;

  get load => _load();

  Future<Result<void>> _load() async {
    try {
      final result = await _taskRepository.getTaskHistoryList();

      switch (result) {
        case Ok<List<TaskHistoryEntity>>():
          _taskHistoryList = result.value;
          return Result.ok(null);
        case Error<List<TaskHistoryEntity>>():
          return Result.error(result.error);
      }
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }
}