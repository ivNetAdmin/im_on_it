import 'package:freezed_annotation/freezed_annotation.dart';

import '../../ui/shared_helpers/date_format_helper.dart';

part 'task_history_entity.freezed.dart';
part 'task_history_entity.g.dart';

@freezed
abstract class TaskHistoryEntity with _$TaskHistoryEntity {

  const factory TaskHistoryEntity({
    /// Optional ID of the task.
    /// May be null if the task is not yet stored.
    int? id,

    /// original task id
    required int taskId,

    /// Date task was created
    required int createDate,

    /// Date task was last completed
    /// May be null if the task is not yet completed.
    required int lastCompletedDate,

    /// task description
    required String description,

    /// task type: fun, chore, bground, yes_dear
    required String type,

    /// task time span to finish task: d3, w, w2, m, m3, m6, y
    required String timeSpan,

    /// task time period when the task could be tackled: d, wd, we
    required String timePeriod,

    /// task repeat: yes/no
    required int repeat,

    /// task repeat: yes/no
    required int lapsed,

  }) = _TaskHistoryEntity;

  factory TaskHistoryEntity.fromJson(Map<String, dynamic> json) =>
      _$TaskHistoryEntityFromJson(json);

}