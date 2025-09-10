import 'dart:async';

import 'package:flutter/material.dart';
import 'package:im_on_it/utils/format_message.dart';

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

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  final TaskRepositoryInterface _taskRepository;

  late Command0 loadCmd;

  get load => _load();

  List<TaskHistory> _taskHistoryList = [];

  List<TaskHistory> get taskHistoryList => _taskHistoryList;

  void clearMessage() {
    _errorMessage = '';
    notifyListeners();
  }

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
            taskId: taskHistoryEntity.taskId,
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

  Future<void> rescheduleTask(TaskHistory taskHistory) async {
    // Is this task a repeating task already scheduled
    int originalTaskId = taskHistory.taskId;

    try{

    final result = await _taskRepository.rescheduleTask(originalTaskId);

    switch(result)
    {
      case Ok<int>():
       // TaskEntity originalTask = result.value;
        _errorMessage = 'task rescheduled';
      case Error<int>():
        _errorMessage = result.error.getMessage;
    }

    } on Exception catch (exception) {
      _errorMessage = exception.getMessage;
    }

    notifyListeners();
    Timer(const Duration(seconds: 3), clearMessage);

  }

  Future<void> deleteTask(TaskHistory taskHistory) async {

   // final result = await _taskRepository.getTaskHistoryList();
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