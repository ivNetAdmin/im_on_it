import 'package:flutter_test/flutter_test.dart';
import 'package:im_on_it/data/entities/task_entity.dart';
import 'package:im_on_it/data/services/task_service_interface.dart';
import '../fakes/fake_task_service.dart';

void main() {
  group('TaskService tests', () {
    late TaskServiceInterface taskService;

    setUp(() {
      taskService = FakeTaskService() as TaskServiceInterface;
    });

    test('should get a data model task list', () async {
      List<TaskEntity> tasks = await taskService.getTaskList();
      expect(tasks.length, 3);
    });

    test('should add task to task database', () async {
      int now = DateTime
          .now()
          .microsecondsSinceEpoch;

      TaskEntity newTask = TaskEntity(
        id: 4,
        description: 'My new task!',
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

    test('should delete task list', () async {
      List<TaskEntity> tasks = await taskService.getTaskList();
      expect(tasks.length, 3);

      TaskEntity taskToDelete = tasks[0];

      int rowId = await taskService.deleteTask(taskToDelete);
      tasks = await taskService.getTaskList();

      expect(rowId, taskToDelete.id);
      expect(tasks.length, 2);
    });

    test('should update task with new value', () async {
      List<TaskEntity> tasks = await taskService.getTaskList();
      expect(tasks.length, 3);

      int taskToUpdateId = tasks[0].id ?? 0;
      String oldTaskDescription = tasks[0].description;

      TaskEntity newTask = TaskEntity(
        id: taskToUpdateId,
        description: 'Updated Task Description!',
        createDate: tasks[0].createDate,
        lastCompletedDate: tasks[0].lastCompletedDate,
        type: tasks[0].type,
        timeSpan: tasks[0].timeSpan,
        timePeriod: tasks[0].timePeriod,
        repeat: tasks[0].repeat,
      );

      int rowId = await taskService.updateTask(newTask);
      tasks = await taskService.getTaskList();

      expect(tasks[0].id, rowId);
      expect(tasks[0].description, 'Updated Task Description!');
      expect(tasks[0].description, isNot(oldTaskDescription));
    });
  });
}

