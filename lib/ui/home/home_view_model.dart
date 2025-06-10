import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';

import '../../data/repository/task_repository_interface.dart';
import '../../domain/models/task.dart';
import '../../utils/command.dart';
import '../../utils/result.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({
    required TaskRepositoryInterface taskRepository,
  }) : _taskRepository = taskRepository {
    loadCmd = Command0(_load)
      ..execute();
  }

  final TaskRepositoryInterface _taskRepository;

  final List<Color> _buttonColours = [];

  List<Color> get buttonColours => _buttonColours;

  final List<String> _buttonText = [
    'Chore',
    'Fun',
    'Yes Dear',
    '3 Day',
    'Week',
    '2 Week',
    '',
    'Month',
    '3 Month',
    '',
    '6 Month',
    'Annual',
    'Any Day',
    'Weekday',
    'Weekend'
  ];

  List<String> get buttonText => _buttonText;

  late Command0 loadCmd;

  get load => _load();

  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Task _newTask = Task(
    id: Guid.newGuid.toString(),
    description: '',
    createDate: DateTime.now(),
    lastCompletedDate: DateTime.now(),
    type: 'chore',
    timeSpan: 'd3',
    timePeriod: 'd',
    repeat: false,
  );

  Task get newTask => _newTask;

  bool _currentTaskRepeatStatus = false;

  DateTime _selectedStartDate = DateTime.now();

  Future<Result> _load() async {
    try {
      setInitialButtonColours();
      _selectedStartDate = DateTime(1958,12,18);

      final result = await _taskRepository.getTaskList();
      switch (result) {
        case Ok<List<Task>>():
          _tasks = setDisplayOrder(result.value);
        case Error<List<Task>>():
          var err = result.error;
      }
      return result;
    } finally {
      notifyListeners();
    }
  }

  List<Task> setDisplayOrder(List<Task> tasks) {
    tasks = removeLapsedTasks(tasks);
    tasks = removeTimePeriodTasks(tasks);

    tasks.sort((b, a) {
      return a.displayOrder.compareTo(b.displayOrder);
    });
    return tasks;
  }

  List<Task> removeLapsedTasks(List<Task> tasks) {
    List<Task> cleanList = [];

    for (var i = 0; i < tasks.length; i++) {
      if (tasks[i].displayTimeLapsed() > 100) {
        if (tasks[i].type == 'yes_dear') {
          cleanList.add(tasks[i]);
        }
      } else {
        cleanList.add(tasks[i]);
      }
    }
    return cleanList;
  }

  List<Task> removeTimePeriodTasks(List<Task> tasks) {
    List<Task> cleanList = [];
    var today = DateTime
        .now()
        .weekday;
    //sat = 6, sun = 7
    for (var i = 0; i < tasks.length; i++) {
      switch (tasks[i].timePeriod) {
      // case 'd':
      //   cleanList.add(tasks[i]);
      //   break;
        case 'wd':
          if (today < 6) {
            cleanList.add(tasks[i]);
          }
          break;
        case 'we':
          if (today > 5) {
            cleanList.add(tasks[i]);
          }
          break;
      }
    }
    return cleanList;
  }

  void setTaskAttribute(int index) {
    if (index < 3) {
      _buttonColours[0] = Colors.green;
      _buttonColours[1] = Colors.green;
      _buttonColours[2] = Colors.green;
      _buttonColours[index] = Colors.green.shade200;
    } else if (index < 12) {
      _buttonColours[3] = Colors.blue;
      _buttonColours[4] = Colors.blue;
      _buttonColours[5] = Colors.blue;
      _buttonColours[6] = Colors.blue;
      _buttonColours[7] = Colors.blue;
      _buttonColours[8] = Colors.blue;
      _buttonColours[9] = Colors.blue;
      _buttonColours[10] = Colors.blue;
      _buttonColours[11] = Colors.blue;
      _buttonColours[index] = Colors.blue.shade200;
    } else {
      _buttonColours[12] = Colors.orange;
      _buttonColours[13] = Colors.orange;
      _buttonColours[14] = Colors.orange;
      _buttonColours[index] = Colors.orange.shade200;
    }

    setNewTaskAttribute(index);

    notifyListeners();
  }

  String newTaskToString() {

    return '${_newTask.repeat} ${_newTask.timeSpan} ${_newTask.timePeriod} ${_newTask
        .lastCompletedDate} ${_newTask
        .displayTimeLapsed()} ${_newTask.type} ${_newTask.description}';
  }

  void setNewTaskAttribute(int index) {
    String type = _newTask.type;
    bool repeat = _newTask.repeat;
    String timeSpan = _newTask.timeSpan;
    String timePeriod = _newTask.timePeriod;

    switch (index) {
      case 0:
        type = 'chore';
      case 1:
        type = 'fun';
      case 2:
        type = 'yes_dear';
      case 3:
        timeSpan = 'd3';
      case 4:
        timeSpan = 'w';
      case 5:
        timeSpan = 'w2';
      case 7:
        timeSpan = 'm';
      case 8:
        timeSpan = 'm3';
      case 10:
        timeSpan = 'm6';
      case 11:
        timeSpan = 'y';
      case 12:
        timePeriod = 'd';
      case 13:
        timePeriod = 'wd';
      case 14:
        timePeriod = 'we';
      case 99:
        repeat = true;
    }

    _newTask = Task(
      id: _newTask.id,
      description: _newTask.description,
      createDate: _newTask.createDate,
      lastCompletedDate: _newTask.lastCompletedDate,
      type: type,
      timeSpan: timeSpan,
      timePeriod: timePeriod,
      repeat: repeat,
    );
  }

  void setNewTaskDate(DateTime selectedDate) {
    _newTask = Task(
      id: _newTask.id,
      description: _newTask.description,
      createDate: selectedDate,
      lastCompletedDate: selectedDate,
      type: _newTask.type,
      timeSpan: _newTask.timeSpan,
      timePeriod: _newTask.timePeriod,
      repeat: _newTask.repeat,
    );
    _selectedStartDate=selectedDate;

    notifyListeners();
  }

  String showNewTaskOptionStartDate() {
    if(_selectedStartDate==DateTime(1958,12,18)) {
      return 'Optional Start Date';
    }
    return 'Start Date ${formatDate(_selectedStartDate)}';
  }

  void setNewTaskDescription(String value) {
    _newTask = Task(
      id: _newTask.id,
      description: value,
      createDate: _newTask.createDate,
      lastCompletedDate: _newTask.lastCompletedDate,
      type: _newTask.type,
      timeSpan: _newTask.timeSpan,
      timePeriod: _newTask.timePeriod,
      repeat: _newTask.repeat,
    );
    notifyListeners();
  }

  void saveNewTask() {
    _load();
    //notifyListeners();
  }

  Future<void> setInitialButtonColours() async {
    _buttonColours.clear();

    _buttonColours.add(Colors.green.shade200);
    _buttonColours.add(Colors.green);
    _buttonColours.add(Colors.green);
    _buttonColours.add(Colors.blue.shade200);
    _buttonColours.add(Colors.blue);
    _buttonColours.add(Colors.blue);
    _buttonColours.add(Colors.blue);
    _buttonColours.add(Colors.blue);
    _buttonColours.add(Colors.blue);
    _buttonColours.add(Colors.blue);
    _buttonColours.add(Colors.blue);
    _buttonColours.add(Colors.blue);
    _buttonColours.add(Colors.orange.shade200);
    _buttonColours.add(Colors.orange);
    _buttonColours.add(Colors.orange);

  }

  String getRepeatStatus() {
    if(_currentTaskRepeatStatus) {
      return "Repeat";
    }else{
      return "Don't Repeat";
    }
  }

  void setRepeatStatus() {
    if(_currentTaskRepeatStatus) {
      _currentTaskRepeatStatus=false;
    }else{
      _currentTaskRepeatStatus=true;
    }
    _newTask = Task(
      id: _newTask.id,
      description: _newTask.description,
      createDate: _newTask.createDate,
      lastCompletedDate: _newTask.lastCompletedDate,
      type: _newTask.type,
      timeSpan: _newTask.timeSpan,
      timePeriod: _newTask.timePeriod,
      repeat: _currentTaskRepeatStatus,
    );

    notifyListeners();
  }

  Color getDateButtonColour() {
    if(_selectedStartDate==DateTime(1958,12,18)) {
      return Colors.deepPurple;
    }else{
      return Colors.deepPurple.shade200;
    }
  }

  Color getRepeatButtonColour() {
    if(!_currentTaskRepeatStatus) {
      return Colors.deepPurple;
    }else{
      return Colors.deepPurple.shade200;
    }
  }
}

String formatDate(DateTime selectedStartDate) {
  String day = selectedStartDate.day.toString();
  if(selectedStartDate.day<10) {
    day = '0${selectedStartDate.day}';
  }

  String month = selectedStartDate.month.toString();
  if(selectedStartDate.month<10) {
    month = '0${selectedStartDate.month}';
  }

  return '$day-$month-${selectedStartDate.year}';
}

