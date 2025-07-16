import 'package:im_on_it/data/entities/task_entity_log.dart';

List<TaskEntityLog> createTaskLogList() {

  int now = DateTime.now().microsecondsSinceEpoch;

  final taskLogs = List<TaskEntityLog>.empty(growable: true);

  taskLogs.add(
    TaskEntityLog(
      id: 1,
      description: 'My first task! [fun d3 no-repeat]',
      lastCompletedDate: now,
      lapsed: 0,
    ),
  );

  taskLogs.add(
    TaskEntityLog(
      id: 2,
      description: 'My next task! [chore w wd repeat]',
      lastCompletedDate: now,
      lapsed: 1,
    ),
  );

  taskLogs.add(
      TaskEntityLog(
        id: 3,
        description: 'My next next task! [yes_dear m no-repeat]',
        lastCompletedDate: now,
        lapsed: 0,
      ),
  );

  return taskLogs;
}