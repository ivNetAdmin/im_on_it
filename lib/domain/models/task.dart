import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart';
//f

@freezed
abstract class Task with _$Task {
  const factory Task({
    /// Optional ID of the task.
    /// May be null if the task is not yet stored.
    int? id,

    /// Date task was created
    required DateTime createDate,

    /// task description
    required String description,


  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) =>
      _$TaskFromJson(json);

}