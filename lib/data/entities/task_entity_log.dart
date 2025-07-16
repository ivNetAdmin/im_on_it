import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_entity_log.freezed.dart';
part 'task_entity_log.g.dart';

@freezed
abstract class TaskEntityLog with _$TaskEntityLog {

  const factory TaskEntityLog({
    /// Optional ID of the task.
    /// May be null if the task is not yet stored.
    int? id,

    /// Date task was last completed
    /// May be null if the task is not yet completed.
    required int lastCompletedDate,

    /// task description
    required String description,

    /// task repeat: yes/no
    required int lapsed,

  }) = _TaskEntityLog;

  factory TaskEntityLog.fromJson(Map<String, dynamic> json) =>
      _$TaskEntityLogFromJson(json);

}