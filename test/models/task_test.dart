import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:im_on_it/domain/enums/time_span_enum.dart';
import 'package:im_on_it/domain/models/task.dart';

import '../utils/create_task_list.dart';

void main() {

  List<Task> _tasks = [];

  setUp(() {
    _tasks =  createTaskList();
  });

  group('TaskModel tests', () {
    test('targetDate custom method time span = day (d)', ()
    {
      var createDateValue = _tasks[0].createDate.millisecondsSinceEpoch;
      var targetDateValue = _tasks[0].targetDate().millisecondsSinceEpoch;
      var dateDifference = targetDateValue-createDateValue;

      var enumByName  = TimeSpanEnum.values.byName(_tasks[0].timeSpan);
      expect(enumByName.toString(),'TimeSpanEnum.d');
      expect(enumByName.value,1); // 1 days

      expect(dateDifference,86400000); //86400000 = 1 day

    });

    test('targetDate custom method time span = week (w)', ()
    {
      var createDateValue = _tasks[1].createDate.millisecondsSinceEpoch;
      var targetDateValue = _tasks[1].targetDate().millisecondsSinceEpoch;
      var dateDifference = targetDateValue-createDateValue;

      var enumByName  = TimeSpanEnum.values.byName(_tasks[1].timeSpan);
      expect(enumByName.toString(),'TimeSpanEnum.w');
      expect(enumByName.value,7); // 7 days

      expect(dateDifference,604800000); //604800000 = 7 days

    });

    test('displayTimeLapsed custom method time span = 2 week (w2)', ()
    {
      // time elapsed 7 days (50%) of 2 week time span
      var dateCreated = DateTime.now().subtract(Duration(days: 7));

      var task = Task(
        id: Guid.newGuid.toString(),
        description: 'My next next task!',
        createDate: dateCreated,
        lastCompletedDate: dateCreated,
        type: 'yes_dear',
        timeSpan: 'w2',
        timePeriod: 'we',
        repeat: true,
      );

      expect(task.displayTimeLapsed(),50);

    });
  });
}