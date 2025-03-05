import 'package:flutter_test/flutter_test.dart';
import 'package:im_on_it/data/services/task_service.dart';

import '../fakes/fake_task_service_api.dart';

void main() {
  group('DataServiceAPI tests', () {
    late TaskService taskServiceAPI;

    setUp(() {
      taskServiceAPI = FakeTaskServiceAPI() as TaskService;
    });

    test('should get json task list', () async {
      var result = await taskServiceAPI.getTaskListJson();

      expect(result.toString(),
          '[{"id":0,"createDate":"2025-01-23T00:00:00.000Z","description":"My first task!"},'
              '{"id":1,"createDate":"2025-01-23T00:00:00.000Z","description":"My next task!"},'
              '{"id":2,"createDate":"2025-01-23T00:00:00.000Z","description":"My next next task!"}]');
    });
  });
}

