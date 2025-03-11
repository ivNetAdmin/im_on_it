import 'package:flutter_test/flutter_test.dart';
import 'package:im_on_it/ui/home/home_view_model.dart';

import '../fakes/fake_lapsed_task_Repository.dart';
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

    test('remove lapsed task - yes_dear', () async {
      final homeViewModel = HomeViewModel(
          taskRepository: FakeLapsedTaskRepository()
      );

      await homeViewModel.load;
      expect(homeViewModel.tasks.length, 2);

      //not removed because it is a yes dear task
      expect(homeViewModel.tasks[0].displayTimeLapsed(),700);
      expect(homeViewModel.tasks[0].timeSpan,'d');
      expect(homeViewModel.tasks[0].type,'yes_dear');

      //not removed because time lapsed is not greater than 100%
      expect(homeViewModel.tasks[1].displayTimeLapsed(),100);
      expect(homeViewModel.tasks[1].timeSpan,'w');
      expect(homeViewModel.tasks[1].type,'chore');
    });

  });
}
