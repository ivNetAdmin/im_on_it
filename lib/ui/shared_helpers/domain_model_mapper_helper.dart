import '../../data/entities/task_history_entity.dart';
import '../../domain/models/task_history.dart';

class DomainModelMapperHelper {

  static List<TaskHistory> mapTaskHistory(List<TaskHistoryEntity> taskHistoryEntities) {
    final taskHistoryList = List<TaskHistory>.empty(growable: true);

    for (final taskHistoryEntity in taskHistoryEntities) {
      taskHistoryList.add(
        TaskHistory(
          id: taskHistoryEntity.id,
          taskId: taskHistoryEntity.taskId,
          createDate: DateTime.fromMicrosecondsSinceEpoch(
              taskHistoryEntity.createDate),
          lastCompletedDate: DateTime.fromMicrosecondsSinceEpoch(
              taskHistoryEntity.lastCompletedDate),
          description: taskHistoryEntity.description,
          type: taskHistoryEntity.type,
          timeSpan: taskHistoryEntity.timeSpan,
          timePeriod: taskHistoryEntity.timePeriod,
          repeat: taskHistoryEntity.repeat == 1 ? true : false,
        ),
      );
    }
    return taskHistoryList;
  }
}