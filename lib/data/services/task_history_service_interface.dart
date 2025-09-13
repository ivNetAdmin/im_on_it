import '../../domain/models/task_history.dart';
import '../entities/task_history_entity.dart';

abstract class TaskHistoryServiceInterface {
  Future<List<TaskHistoryEntity>> getAllTaskHistory();
  Future<int>addNewTaskHistory(TaskHistoryEntity newTaskHistory);

  Future<TaskHistoryEntity> getTaskHistoryEntityByTaskId(int taskId);

  Future<int> deleteTaskHistory(TaskHistory taskHistory);
}