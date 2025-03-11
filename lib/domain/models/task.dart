import 'package:flutter_guid/flutter_guid.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart';
//f

@freezed
abstract class Task with _$Task {
  const factory Task({
    /// Optional ID of the task.
    /// May be null if the task is not yet stored.
    String? id,

    /// Date task was created
    required DateTime targetDate,

    /// task description
    required String description,

    /// task type: fun, chore, bground, yes_dear
    required String type,

    /// task time span to finish task: d, 3d, w, 2w, m, 3m, 6m, y
    required String timeSpan,

    /// task time period when the task could be tackled: d, wd, we
    required String timePeriod,

    /// task repeat: yes/no
    required bool repeat,

    // Optional display order of the task.
    /// May be null as this order is created on the fly
    int? displayOrder,

    // Optional display time lapsed - % of time eg 1 lapsed w of a 2w task = 50
    /// May be null as this order is created on the fly
    int? displayTimeLapsed

  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) =>
      _$TaskFromJson(json);

}