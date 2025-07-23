import 'package:im_on_it/data/entities/task_history_entity.dart';

List<TaskHistoryEntity> createTaskHistoryList() {

  int now = DateTime.now().microsecondsSinceEpoch;

  final taskHistory = List<TaskHistoryEntity>.empty(growable: true);

  taskHistory.add(
    TaskHistoryEntity(
      id: 1,
      taskId: 1,
      description: 'My first task!',
      createDate: now,
      lastCompletedDate: now,
      type: 'fun',
      timeSpan: 'd3',
      timePeriod: 'd',
      repeat: 0,
      lapsed: 0,
    ),
  );

  taskHistory.add(
    TaskHistoryEntity(
      id: 2,
      taskId: 2,
      description: 'My next task!',
      createDate: now,
      lastCompletedDate: now,
      type: 'chore',
      timeSpan: 'w',
      timePeriod: 'wd',
      repeat: 1,
      lapsed: 1,
    ),
  );

  taskHistory.add(
      TaskHistoryEntity(
        id: 3,
        taskId: 3,
        description: 'My next next task!',
        createDate: now,
        lastCompletedDate: now,
        type: 'yes_dear',
        timeSpan: 'm',
        timePeriod: 'we',
        repeat: 0,
        lapsed: 0,
      ),
  );

  return taskHistory;
}