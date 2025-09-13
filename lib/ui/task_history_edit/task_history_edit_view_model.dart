import 'package:flutter/material.dart';

import '../../data/entities/task_history_entity.dart';
import '../../data/repository/task_repository_interface.dart';
import '../../domain/models/task_history.dart';
import '../../utils/command.dart';
import '../../utils/result.dart';
import '../shared_helpers/domain_model_mapper_helper.dart';
import '../shared_helpers/snack_bar_helper.dart';

class TaskHistoryEditViewModel extends ChangeNotifier {

  TaskHistoryEditViewModel({
    required TaskRepositoryInterface taskRepository,
  }) : _taskRepository = taskRepository {
    loadCmd = Command0(_load)
      ..execute();
  }

  final TaskRepositoryInterface _taskRepository;

  late Command0 loadCmd;

  get load => _load();

  String? taskId;

  List<TaskHistory> _taskHistoryList = [];
  List<TaskHistory> get taskHistoryList => _taskHistoryList;

  late TaskHistory _selectedTask;
  TaskHistory get selectedTask => _selectedTask;

  Future<Result<void>> _load() async {

    try {

      final result = await _taskRepository.getTaskHistoryList();

      switch (result) {
        case Ok<List<TaskHistoryEntity>>():
          _taskHistoryList = DomainModelMapperHelper.mapTaskHistory(result.value,taskId);
          _selectedTask = _taskHistoryList[0];

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

  Future<void> deleteTaskHistory(BuildContext context, TaskHistory taskHistory) async {

    final result = await _taskRepository.deleteTaskHistory(taskHistory);
    switch(result)
    {
      case Ok<int>():
        if(context.mounted) {
          SnackBarHelper.showFlashError(context, 'task history deleted', 'info');
        }
        _load();
      case Error<int>():
        if(context.mounted) {
          SnackBarHelper.showFlashError(context, result.toString(), 'error');
        }
    }

    notifyListeners();
  }

}