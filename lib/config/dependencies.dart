import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/repository/dev/task_repository.dart';
import '../data/services/dev/task_service.dart';

List<SingleChildWidget> get providers {
  return [
    Provider.value(
      value: TaskService(),
    ),
    Provider(
        create: (context) =>
        TaskRepository(
          taskService: context.read(),
        )
    ),
  ];
}