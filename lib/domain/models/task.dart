import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/time_span_enum.dart';

part 'task.freezed.dart';
part 'task.g.dart';
//f

@freezed
abstract class Task with _$Task {

  const Task._();

  const factory Task({
    /// Optional ID of the task.
    /// May be null if the task is not yet stored.
    String? id,

    /// Date task was created
    required DateTime createDate,

    /// Date task was last completed
    /// /// May be null if the task is not yet completed.
    DateTime? lastCompletedDate,

    /// task description
    required String description,

    /// task type: fun, chore, bground, yes_dear
    required String type,

    /// task time span to finish task: d, d3, w, w2, m, m3, m6, y
    required String timeSpan,

    /// task time period when the task could be tackled: d, wd, we
    required String timePeriod,

    /// task repeat: yes/no
    required bool repeat,

    // Optional display order of the task.
    /// May be null as this order is created on the fly
    //int? displayOrder,

    // Optional display time lapsed - % of time eg 1 lapsed w of a 2w task = 50
    /// May be null as this order is created on the fly
    //int? displayTimeLapsed

  }) = _Task;

  int displayOrder()
  {
   return 0;
  }

  int displayTimeLapsed()
  {
    return 0;
  }

  DateTime? targetDate()
  {
    // the target date is the createDate + timeSpan days
    var timeSpanEnum  = TimeSpanEnum.values.byName(timeSpan);
    int days = timeSpanEnum.value.toInt();

    var targetDate = lastCompletedDate == null
        ? createDate.add(Duration(days: days))
        : lastCompletedDate?.add(Duration(days: days));

    return targetDate;
  }

  factory Task.fromJson(Map<String, dynamic> json) =>
      _$TaskFromJson(json);

}