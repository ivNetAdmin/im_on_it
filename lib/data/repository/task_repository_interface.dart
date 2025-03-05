import '../../domain/models/task.dart';
import '../../utils/result.dart';

abstract class TaskRepositoryInterface{
  Future<Result<List<Task>>> getTaskList();
}