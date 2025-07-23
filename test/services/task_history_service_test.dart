import 'package:flutter_test/flutter_test.dart';
import 'package:im_on_it/data/entities/task_history_entity.dart';
import 'package:im_on_it/data/services/task_history_service_interface.dart';

import '../fakes/fake_task_history_service.dart';

void main() {
  group('TaskHistoryService tests', () {
    late TaskHistoryServiceInterface taskHistoryService;

    setUp(() {
      taskHistoryService = FakeTaskHistoryService() as TaskHistoryServiceInterface;
    });

    test('should get a data model task history list', () async {
      List<TaskHistoryEntity> taskHistoryList = await taskHistoryService.getAllTaskHistory();
      expect(taskHistoryList.length, 3);
    });

    test('should add task history to task history database', () async {
      int now = DateTime
          .now()
          .microsecondsSinceEpoch;

      TaskHistoryEntity newTaskHistory = TaskHistoryEntity(
        id: 4,
        taskId: 4,
        createDate: now,
        type: 'fun',
        timeSpan: 'd3',
        timePeriod: 'd',
        repeat: 0,
        description: 'My new task history!',
        lastCompletedDate: now,
        lapsed: 0,
      );

      int rowId = await taskHistoryService.addNewTaskHistory(newTaskHistory);
      List<TaskHistoryEntity> taskHistoryList = await taskHistoryService.getAllTaskHistory();

      expect(rowId, 4);
      expect(taskHistoryList.length, 4);
    });
  });
}