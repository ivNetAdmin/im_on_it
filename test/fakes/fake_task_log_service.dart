import 'package:im_on_it/data/entities/task_entity_log.dart';
import 'package:im_on_it/data/services/task_log_service_interface.dart';

import '../utils/create_task_log_list.dart';

class FakeTaskLogService implements TaskLogServiceInterface {

  final _taskLogs = createTaskLogList();

  @override
  Future<int> addNewTaskLog(TaskEntityLog newTaskLog) async {
    _taskLogs.add(newTaskLog);
    return newTaskLog.id ?? 0;
  }

  @override
  Future<List<TaskEntityLog>> getTaskLogList() async {
    return _taskLogs;
  }

}