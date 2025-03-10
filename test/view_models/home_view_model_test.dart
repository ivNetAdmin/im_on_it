import 'package:flutter_test/flutter_test.dart';
import 'package:im_on_it/ui/home/home_view_model.dart';

import '../fakes/fake_task_repository.dart';

void main() {
  group('HomeViewModel tests', () {
    test('should get task list containing 3 tasks', () async {
      final homeViewModel = HomeViewModel(
          taskRepository: FakeTaskRepository()
      );

      await homeViewModel.load;
      expect(homeViewModel.tasks.length, 3);
    });
  });
}
