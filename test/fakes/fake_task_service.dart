
import 'package:im_on_it/data/entities/task_entity.dart';
import 'package:im_on_it/data/services/task_service_interface.dart';
import '../utils/create_task_list.dart';

class FakeTaskService implements TaskServiceInterface {

  final _tasks = createTaskList();

  @override
  Future<List<TaskEntity>> getTaskList() async {
    return _tasks;
  }

  @override
  Future<int> addNewTask(TaskEntity newTask) async {
    _tasks.add(newTask);
    return newTask.id ?? 0;
  }
}