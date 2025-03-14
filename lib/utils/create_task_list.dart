
import 'package:flutter_guid/flutter_guid.dart';

import '../domain/models/task.dart';

List<Task> createTaskList() {
  DateTime now = DateTime.now().subtract(Duration(days: 14));

  final tasks = List<Task>.empty(growable: true);

  tasks.add(
    Task(
      id: Guid.newGuid.toString(),
      description: 'My first task!',
      createDate: now,
      lastCompletedDate: now,
      type: 'fun',
      timeSpan: 'w',
      timePeriod: 'd',
      repeat: false,
    ),
  );

  tasks.add(
    Task(
      id: Guid.newGuid.toString(),
      description: 'My next task!',
      createDate: now,
      lastCompletedDate: now,
      type: 'chore',
      timeSpan: 'm3',
      timePeriod: 'wd',
      repeat: true,
    ),
  );

  tasks.add(
    Task(
      id: Guid.newGuid.toString(),
      description: 'My next next task!',
      createDate: now,
      lastCompletedDate: now,
      type: 'yes_dear',
      timeSpan: 'd',
      timePeriod: 'we',
      repeat: true,
    ),
  );

  return tasks;
}