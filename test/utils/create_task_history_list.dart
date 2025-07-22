import 'package:im_on_it/data/entities/task_history_entity.dart';

List<TaskHistoryEntity> createTaskHistoryList() {

  int now = DateTime.now().microsecondsSinceEpoch;

  final taskHistory = List<TaskHistoryEntity>.empty(growable: true);

  taskHistory.add(
    TaskHistoryEntity(
      id: 1,
      description: 'My first task! [fun d3 no-repeat]',
      lastCompletedDate: now,
      lapsed: 0,
    ),
  );

  taskHistory.add(
    TaskHistoryEntity(
      id: 2,
      description: 'My next task! [chore w wd repeat]',
      lastCompletedDate: now,
      lapsed: 1,
    ),
  );

  taskHistory.add(
      TaskHistoryEntity(
        id: 3,
        description: 'My next next task! [yes_dear m no-repeat]',
        lastCompletedDate: now,
        lapsed: 0,
      ),
  );

  return taskHistory;
}