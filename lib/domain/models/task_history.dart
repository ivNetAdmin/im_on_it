import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_history.freezed.dart';
part 'task_history.g.dart';

@freezed
abstract class TaskHistory with _$TaskHistory {

  const TaskHistory._();

  const factory TaskHistory({
    /// Optional ID of the task.
    /// May be null if the task is not yet stored.
    int? id,

    /// original task id
    required int taskId,

    /// Date task was created
    required DateTime createDate,

    /// Date task was last completed
    /// May be null if the task is not yet completed.
    required DateTime lastCompletedDate,

    /// task description
    required String description,

    /// task type: fun, chore, bground, yes_dear
    required String type,

    /// task time span to finish task: d3, w, w2, m, m3, m6, y
    required String timeSpan,

    /// task time period when the task could be tackled: d, wd, we
    required String timePeriod,

    /// task repeat: yes/no
    required bool repeat,

  }) = _TaskHistory;

  String lastCompletedDateFormatted() {

    String convertedDateTime = "${lastCompletedDate.day.toString().padLeft(
        2, '0')}-${lastCompletedDate.month.toString().padLeft(2, '0')}-${lastCompletedDate.year.toString()}";

    return convertedDateTime;
  }

  String timeSpanText()
  {
    // d3, w, w2, m, m3, m6, y
    switch(timeSpan) {
      case 'd3':
        return ' (3 day)';
      case 'w':
        return ' (weekly)';
      case 'w2':
        return ' (2 weeks)';
      case 'm':
        return ' (month)';
      case 'm3':
        return ' (3 month)';
      case 'm6':
        return ' (6 month)';
      case 'y':
        return ' (annually)';
    }
    return '';
  }

  String timePeriodText() {
    // d, wd, we
    switch(timePeriod) {
      case 'd':
        return ' - Any day';
      case 'wd':
        return ' - Week day';
      case 'we':
        return ' - Weekend';
    }
    return '';
  }

  factory TaskHistory.fromJson(Map<String, dynamic> json) =>
      _$TaskHistoryFromJson(json);

}
