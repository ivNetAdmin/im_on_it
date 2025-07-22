import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_history_entity.freezed.dart';
part 'task_history_entity.g.dart';

@freezed
abstract class TaskHistoryEntity with _$TaskHistoryEntity {

  const factory TaskHistoryEntity({
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

  }) = _TaskHistoryEntity;

  factory TaskHistoryEntity.fromJson(Map<String, dynamic> json) =>
      _$TaskHistoryEntityFromJson(json);

}