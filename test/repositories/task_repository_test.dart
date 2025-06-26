import 'package:flutter_test/flutter_test.dart';
import 'package:im_on_it/data/entities/task_entity.dart';
import 'package:im_on_it/data/repository/task_repository_interface.dart';
import 'package:im_on_it/data/services/task_service_interface.dart';
import 'package:im_on_it/utils/result.dart';

import '../fakes/fake_task_repository.dart';
import '../fakes/fake_task_service.dart';

void main() {
  group('TaskRepository tests', () {
    late TaskRepositoryInterface taskRepository;
    late TaskServiceInterface taskService;

    setUp(() {
      taskService = FakeTaskService() as TaskServiceInterface;

      taskRepository = FakeTaskRepository(
        taskService: taskService,
      ) as TaskRepositoryInterface;

    });

    test('should get task list containing 3 tasks', () async {
      Result result = await taskRepository.getTaskList();

      switch (result) {
        case Ok():
          var tasks = result.value;
          expect(tasks.length, 3);
          expect(tasks[0].id, 1);
          expect(tasks[0].description, 'My first task!');
        case Error():
          {
            throw(Exception('Testing Error!'));
          }
      }
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

      Result result = await taskRepository.addNewTask(newTask);

      switch (result) {
        case Ok():
          int rowId= result.value;
          expect(rowId, 4);
        case Error():
          throw(Exception(result));
      }

      result = await taskRepository.getTaskList();

      switch (result) {
        case Ok():
          List<TaskEntity> tasks = result.value;
          expect(tasks.length, 4);
        case Error():
          throw(Exception(result));
      }

    });

    test('should delete task to task database', () async {

      Result result = await taskRepository.getTaskList();

      switch (result) {
        case Ok():
          var tasks = result.value;
          TaskEntity taskToDelete = tasks[0];

          result = await taskRepository.deleteTask(taskToDelete);

          switch (result) {
            case Ok():
              int rowId= result.value;
              expect(rowId, taskToDelete.id);
            case Error():
              throw(Exception(result));
          }

        case Error():
          {
            throw(Exception('Testing Error!'));
          }
      }

      result = await taskRepository.getTaskList();

      switch (result) {
        case Ok():
          List<TaskEntity> tasks = result.value;
          expect(tasks.length, 2);
        case Error():
          throw(Exception(result));
      }

    });
  });
}