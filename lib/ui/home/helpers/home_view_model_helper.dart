import 'package:im_on_it/domain/models/task.dart';

import '../../../data/entities/task_entity.dart';
import '../../../data/entities/task_history_entity.dart';

class HomeViewModelHelper {
  static Task get newTask => Task(
    id: null,
    description: '',
    createDate: DateTime.now(),
    lastCompletedDate: DateTime.now(),
    type: 'chore',
    timeSpan: 'd3',
    timePeriod: 'd',
    repeat: false,
  );

  static List<String> get buttonText => [
    'Chore',
    'Fun',
    'Yes Dear',
    '3 Day',
    'Week',
    '2 Week',
    '',
    'Month',
    '3 Month',
    '',
    '6 Month',
    'Annual',
    'Any Day',
    'Weekday',
    'Weekend'
  ];

  static TaskEntity setNewTaskEntityDate(TaskEntity taskEntity, int selectedDate){
    return TaskEntity(
      id: taskEntity.id,
      description: taskEntity.description,
      createDate: selectedDate,
      lastCompletedDate: selectedDate,
      type: taskEntity.type,
      timeSpan: taskEntity.timeSpan,
      timePeriod: taskEntity.timePeriod,
      repeat: taskEntity.repeat,
    );
  }

  static TaskHistoryEntity setNewTaskHistoryEntityDate(TaskEntity taskEntity, int selectedDate){

    return TaskHistoryEntity(
    taskId: taskEntity.id ?? 0,
    createDate: taskEntity.createDate,
    type: taskEntity.type,
    timeSpan: taskEntity.timeSpan,
    timePeriod: taskEntity.timePeriod,
    repeat: taskEntity.repeat,
    description: taskEntity.description,
    lastCompletedDate: selectedDate,
    lapsed: 0
    );
  }
}