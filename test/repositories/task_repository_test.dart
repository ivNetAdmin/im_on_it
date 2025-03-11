import 'package:flutter_test/flutter_test.dart';
import 'package:im_on_it/data/repository/dev/task_repository.dart';
import 'package:im_on_it/data/services/task_service_interface.dart';
import 'package:im_on_it/domain/models/task.dart';
import 'package:im_on_it/utils/format_message.dart';
import 'package:im_on_it/utils/result.dart';

import '../fakes/fake_task_error_service.dart';
import '../fakes/fake_task_service.dart';

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
          expect(tasks[0].id,"aaaaaaaa-aaaa-cccc-dddd-eeeeeeeeeeee");
          expect(tasks[0].description, 'My first task!');
        case Error(): {
          throw(Exception('Testing Error!'));
        }
      }
    });

    test('should get service error', () async {
      taskRepository = TaskRepository(
        taskService: taskErrorService,
      );

      Result<List<Task>> result = await taskRepository.getTaskList();

      switch (result) {
        case Ok(): {
          throw(Exception('Testing Error!'));
        }
        case Error(): {
          var errMsg = result.error.getMessage;
          expect(errMsg,'Fake getTaskListJson error');
        }
      }
    });
  });
}