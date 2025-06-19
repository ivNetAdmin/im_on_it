import 'package:im_on_it/data/entities/task_entity.dart';

List<TaskEntity> createTaskList() {
  int now = DateTime.now().microsecondsSinceEpoch;

  final tasks = List<TaskEntity>.empty(growable: true);

  tasks.add(
    TaskEntity(
      id: 1,
      description: 'My first task!',
      createDate: now,
      lastCompletedDate: now,
      type: 'fun',
      timeSpan: 'd3',
      timePeriod: 'd',
      repeat: 0,
    ),
  );

  tasks.add(
    TaskEntity(
      id: 2,
      description: 'My next task!',
      createDate: now,
      lastCompletedDate: now,
      type: 'chore',
      timeSpan: 'w',
      timePeriod: 'wd',
      repeat: 1,
    ),
  );

  tasks.add(
    TaskEntity(
      //id: Guid("aaaaaaaa-cccc-cccc-dddd-eeeeeeeeeeee").toString(),
      id: 3,
      description: 'My next next task!',
      createDate: now,
      lastCompletedDate: now,
      type: 'yes_dear',
      timeSpan: 'm',
      timePeriod: 'we',
      repeat: 0,
    ),
  );

  return tasks;
}


/*

final tasks = List<Map<String, dynamic>>.empty(growable: true);

  tasks.add({
    "id": Guid("aaaaaaaa-aaaa-cccc-dddd-eeeeeeeeeeee").toString(),
    "description": 'My first task!',
    "createDate": now,
    "lastCompletedDate": now,
    "type": 'fun',
    "timeSpan": 'd3',
    "timePeriod": 'd',
    "repeat": 0,
  });

  tasks.add({
    "id": Guid("aaaaaaaa-aaaa-cccc-dddd-eeeeeeeeeeee").toString(),
    "description": 'My next task!',
    "createDate": now,
    "lastCompletedDate": now,
    "type": 'chore',
    "timeSpan": 'w',
    "timePeriod": 'wd',
    "repeat": 1,
  });

  tasks.add({
    "id": Guid("aaaaaaaa-aaaa-cccc-dddd-eeeeeeeeeeee").toString(),
    "description": 'My next task!',
    "createDate": now,
    "lastCompletedDate": now,
    "type": 'yes_dear',
    "timeSpan": 'm',
    "timePeriod": 'we',
    "repeat": 0,
  });
 */