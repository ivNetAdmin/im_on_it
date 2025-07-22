import 'package:im_on_it/data/entities/task_history_entity.dart';
import 'package:im_on_it/data/services/task_history_service_interface.dart';

import '../utils/create_task_history_list.dart';

class FakeTaskHistoryService implements TaskHistoryServiceInterface {

  final _taskHistoryList = createTaskHistoryList();

  @override
  Future<int> addNewTaskHistory(TaskHistoryEntity newTaskHistory) async {
    _taskHistoryList.add(newTaskHistory);
    return newTaskHistory.id ?? 0;
  }

  @override
  Future<List<TaskHistoryEntity>> getAllTaskHistory() async {
    return _taskHistoryList;
  }

}