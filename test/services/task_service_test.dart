import 'package:flutter_test/flutter_test.dart';
import 'package:im_on_it/data/entities/task_entity.dart';
import 'package:im_on_it/data/services/task_service_interface.dart';
import '../fakes/fake_task_service.dart';

void main() {
  group('DataService tests', () {
    late TaskServiceInterface taskService;

    setUp(() {
      taskService = FakeTaskService() as TaskServiceInterface;
    });

    test('should get a data model task list', () async {
      List<TaskEntity> tasks = await taskService.getTaskList();
      expect(tasks.length, 3);
    });

    test('should add task to task database', () async {
      int now = DateTime.now().microsecondsSinceEpoch;

      TaskEntity newTask = TaskEntity(
        id: 4,
        description: 'My first task!',
        createDate: now,
        lastCompletedDate: now,
        type: 'fun',
        timeSpan: 'd3',
        timePeriod: 'd',
        repeat: 0,
      );

      int rowId = await taskService.addNewTask(newTask);
      List<TaskEntity> tasks = await taskService.getTaskList();

      expect(rowId, 4);
      expect(tasks.length, 4);
    });
  });
}

