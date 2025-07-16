import 'package:flutter_test/flutter_test.dart';
import 'package:im_on_it/data/entities/task_entity_log.dart';
import 'package:im_on_it/data/services/task_log_service_interface.dart';

import '../fakes/fake_task_log_service.dart';

void main() {
  group('TaskLogService tests', () {
    late TaskLogServiceInterface taskLogService;

    setUp(() {
      taskLogService = FakeTaskLogService() as TaskLogServiceInterface;
    });

    test('should get a data model task log list', () async {
      List<TaskEntityLog> taskLogs = await taskLogService.getTaskLogList();
      expect(taskLogs.length, 3);
    });

    test('should add task log to task log database', () async {
      int now = DateTime
          .now()
          .microsecondsSinceEpoch;

      TaskEntityLog newTaskLog = TaskEntityLog(
        id: 4,
        description: 'My new task log! [fun d3 no-repeat]',
        lastCompletedDate: now,
        lapsed: 0,
      );

      int rowId = await taskLogService.addNewTaskLog(newTaskLog);
      List<TaskEntityLog> taskLogs = await taskLogService.getTaskLogList();

      expect(rowId, 4);
      expect(taskLogs.length, 4);
    });

  });
}