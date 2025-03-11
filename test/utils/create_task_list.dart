import 'package:flutter_guid/flutter_guid.dart';
import 'package:im_on_it/domain/models/task.dart';

List<Task> createTaskList() {
  DateTime now = DateTime.utc(2025, 01, 23);

  final tasks = List<Task>.empty(growable: true);

  tasks.add(
    Task(
      id: Guid("aaaaaaaa-aaaa-cccc-dddd-eeeeeeeeeeee").toString(),
      description: 'My first task!',
      targetDate: now,
      type: 'fun',
      timeSpan: 'd',
      timePeriod: 'd',
      repeat: false,
    ),
  );

  tasks.add(
    Task(
      id: Guid("aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee").toString(),
      description: 'My next task!',
      targetDate: now,
      type: 'chore',
      timeSpan: 'w',
      timePeriod: 'wd',
      repeat: true,
    ),
  );

  tasks.add(
    Task(
      id: Guid("aaaaaaaa-cccc-cccc-dddd-eeeeeeeeeeee").toString(),
      description: 'My next next task!',
      targetDate: now,
      type: 'yes_dear',
      timeSpan: 'm',
      timePeriod: 'we',
      repeat: true,
    ),
  );

  return tasks;
}