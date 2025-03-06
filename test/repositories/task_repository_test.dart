import 'package:flutter_test/flutter_test.dart';
import 'package:im_on_it/data/repository/dev/task_repository.dart';
import 'package:im_on_it/data/services/task_service_interface.dart';
import 'package:im_on_it/domain/models/task.dart';
import 'package:im_on_it/utils/result.dart';

import '../fakes/fake_task_error_service.dart';
import '../fakes/fake_task_service.dart';

DateTime _now = DateTime.utc(2025, 01, 23);

void main() {
  group('TaskRepository tests', () {
    late TaskRepository taskRepository;
    late TaskServiceInterface fakeTaskService;
    late TaskServiceInterface taskErrorService;

    setUp(() {
      fakeTaskService = FakeTaskService() as TaskServiceInterface;
      taskErrorService = FakeTaskErrorService() as TaskServiceInterface;
    });

    test('should get task list containing 3 tasks', () async {
      taskRepository = TaskRepository(
        taskService: fakeTaskService,
      );

      Result<List<Task>> result = await taskRepository.getTaskList();

      switch (result) {
        case Ok<List<Task>>():
          var tasks = result.value;
          expect(tasks.length, 3);
          expect(tasks[0].id, 0);
          expect(tasks[0].description, 'My first task!');
          expect(tasks[0].createDate, _now);
        case Error(): {}
      }
    });

    test('should get service error', () async {
      taskRepository = TaskRepository(
        taskService: taskErrorService,
      );

      Result<List<Task>> result = await taskRepository.getTaskList();

      switch (result) {
        case Ok(): {}
        case Error(): {
          expect(result.error.toString(),'Exception: Exception: Fake getTaskListJson error');
        }
      }
    });
  });
}