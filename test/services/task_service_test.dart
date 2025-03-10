import 'package:flutter_test/flutter_test.dart';
import 'package:im_on_it/data/services/task_service_interface.dart';
import 'package:im_on_it/utils/format_message.dart';
import 'package:im_on_it/utils/result.dart';

import '../fakes/fake_task_error_service.dart';
import '../fakes/fake_task_service.dart';

void main() {
  group('DataService tests', () {
    late TaskServiceInterface taskService;
    late TaskServiceInterface taskErrorService;

    setUp(() {
      taskService = FakeTaskService() as TaskServiceInterface;
      taskErrorService = FakeTaskErrorService() as TaskServiceInterface;
    });

    test('should get json task list', () async {
      var result = await taskService.getTaskListJson();

      switch (result) {
        case Ok():
          {
            expect(result.value,
                '[{"id":0,"createDate":"2025-01-23T00:00:00.000Z","description":"My first task!"},'
                    '{"id":1,"createDate":"2025-01-23T00:00:00.000Z","description":"My next task!"},'
                    '{"id":2,"createDate":"2025-01-23T00:00:00.000Z","description":"My next next task!"}]');
          }
        case Error():
          {
            throw(Exception('Testing Error!'));
          }
      }
    });

    test('should get error', () async {
      var result = await taskErrorService.getTaskListJson();

      switch (result) {
        case Ok():
          {
            throw(Exception('Testing Error!'));
          }
        case Error():
          {
            expect(result.error.getMessage, 'Fake getTaskListJson error');
          }
      }
    });
  });
}

