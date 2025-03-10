import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/repository/dev/task_repository.dart';
import '../data/repository/task_repository_interface.dart';
import '../data/services/dev/task_service.dart';
import '../data/services/task_service_interface.dart';

List<SingleChildWidget> get providers {
  return [
    Provider.value(
      value: TaskService() as TaskServiceInterface,
    ),
    Provider(
        create: (context) =>
        TaskRepository(taskService: context.read(),) as TaskRepositoryInterface
    ),
  ];
}
