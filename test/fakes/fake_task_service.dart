
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

  @override
  Future<int> deleteTask(TaskEntity task) async {
    var taskId = task.id ?? 0;
    for (var i = 0; i < _tasks.length; i++) {
      if (_tasks[i].id == taskId) {
        _tasks.remove(task);
        return taskId;
      }
    }
    return taskId;
  }

  @override
  Future<void> deleteDb() {
    // TODO: implement deleteDb
    throw UnimplementedError();
  }

  @override
  Future<int> updateTask(TaskEntity task) async {
    var taskId = task.id ?? 0;
    for (var i = 0; i < _tasks.length; i++) {
      if (_tasks[i].id == taskId) {
        _tasks[i] = task;
        return taskId;
      }
    }
    return taskId;
  }

  @override
  Future<TaskEntity> getTask(int taskId) {
    // TODO: implement getTask
    throw UnimplementedError();
  }
}