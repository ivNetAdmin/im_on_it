import '../../utils/result.dart';

abstract class TaskServiceInterface {
  Future<Result<String>>getTaskListJson();
}