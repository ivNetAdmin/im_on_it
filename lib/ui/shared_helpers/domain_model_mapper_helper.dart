import '../../data/entities/task_history_entity.dart';
import '../../domain/models/task_history.dart';

class DomainModelMapperHelper {

  static List<TaskHistory> mapTaskHistory(List<TaskHistoryEntity> taskHistoryEntities, String? taskId) {
    final taskHistoryList = List<TaskHistory>.empty(growable: true);

    int taskIdValue = taskId == null ? 0 : int.parse(taskId);

    for (final taskHistoryEntity in taskHistoryEntities) {

      if(taskHistoryEntity.taskId == taskIdValue || taskIdValue == 0)
        {
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
    }
    return taskHistoryList;
  }
}