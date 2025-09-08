import 'dart:async';

import 'package:flutter/material.dart';

import '../../data/entities/task_history_entity.dart';
import '../../domain/models/task_history.dart';
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

  late Command0 loadCmd;

  get load => _load();

  List<TaskHistory> _taskHistoryList = [];

  List<TaskHistory> get taskHistoryList => _taskHistoryList;

  Future<Result<void>> _load() async {
    try {
      final result = await _taskRepository.getTaskHistoryList();

      switch (result) {
        case Ok<List<TaskHistoryEntity>>():
          _taskHistoryList = mapTaskHistory(result.value);
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

  List<TaskHistory> mapTaskHistory(List<TaskHistoryEntity> taskHistoryEntities) {
    final taskHistoryList = List<TaskHistory>.empty(growable: true);

    for (final taskHistoryEntity in taskHistoryEntities) {
      taskHistoryList.add(
          TaskHistory(
            id: taskHistoryEntity.id,
            createDate: DateTime.fromMicrosecondsSinceEpoch(
                taskHistoryEntity.createDate),
            lastCompletedDate: DateTime.fromMicrosecondsSinceEpoch(
                taskHistoryEntity.lastCompletedDate),
            description: taskHistoryEntity.description,
            type: taskHistoryEntity.type,
            timeSpan: taskHistoryEntity.timeSpan,
            timePeriod: taskHistoryEntity.timePeriod,
            repeat: taskHistoryEntity.repeat == 1 ? true : false,
          ),
      );
    }
    return taskHistoryList;
  }

  IconData? getTypeIcon(String type) {
    switch(type) {
      case 'chore':
        return Icons.handyman_outlined;
      case 'fun':
        return Icons.sentiment_satisfied_alt;
    }
    return Icons.notifications_active_outlined;
  }

  Future<void> deleteTask(TaskHistory taskHistory) async {

    final result = await _taskRepository.getTaskHistoryList();
    /*
    switch(result)
    {
      case Ok<List<TaskHistoryEntity>>():
        // TODO: Handle this case.
        _errorMessage = 'task deleted';
      case Error<List<TaskHistoryEntity>>():
        // TODO: Handle this case.
        throw UnimplementedError();
    }
*/
    notifyListeners();
  }
}