import 'package:im_on_it/data/services/task_service_interface.dart';
import 'package:im_on_it/utils/result.dart';

class FakeTaskErrorService implements TaskServiceInterface {

  @override
  Future<Result<String>> getTaskListJson() async {
    return Result.error(Exception('Fake getTaskListJson error'));
  }
 }