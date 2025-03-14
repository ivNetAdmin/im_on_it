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
    required DateTime lastCompletedDate,

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

  get displayOrder {
    return displayTimeLapsed();
  }

  int displayTimeLapsed()
  {
    // daysLapsed = today - lastCompletedDate
    // time elapsed (%) is (daysLapsed/timeSpan) * 100

    int daysLapsed = DateTime.now().difference(lastCompletedDate).inDays;

    var timeSpanEnum  = TimeSpanEnum.values.byName(timeSpan);
    int timeSpanDays = timeSpanEnum.value.toInt();

    return ((daysLapsed/timeSpanDays) * 100).round();
  }

  DateTime targetDate()
  {
    // the target date is the createDate or lastCompletedDate + timeSpan days
    var timeSpanEnum  = TimeSpanEnum.values.byName(timeSpan);
    int days = timeSpanEnum.value.toInt();
    return lastCompletedDate.add(Duration(days: days));
  }

  factory Task.fromJson(Map<String, dynamic> json) =>
      _$TaskFromJson(json);

}