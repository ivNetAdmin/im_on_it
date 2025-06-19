import 'package:im_on_it/domain/models/task.dart';

class HomeViewModelHelper {
  static Task get newTask => Task(
    id: null,
    description: '',
    createDate: DateTime.now(),
    lastCompletedDate: DateTime.now(),
    type: 'chore',
    timeSpan: 'd3',
    timePeriod: 'd',
    repeat: false,
  );

  static List<String> get buttonText => [
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

}