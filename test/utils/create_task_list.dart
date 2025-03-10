import 'package:im_on_it/domain/models/task.dart';

List<Task> createTaskList() {
  int sequentialId = 0;
  DateTime now = DateTime.utc(2025, 01, 23);

  final tasks = List<Task>.empty(growable: true);

    tasks.add(
      Task(
        id: sequentialId++,
        description: 'My first task!',
        createDate: now, //  (2025, 1, 6),
      ),
    );

    tasks.add(
      Task(
        id: sequentialId++,
        description: 'My next task!',
        createDate: now, //  (2025, 1, 6),
      ),
    );

    tasks.add(
      Task(
        id: sequentialId++,
        description: 'My next next task!',
        createDate: now, //  (2025, 1, 6),
      ),
    );

  return tasks;
}