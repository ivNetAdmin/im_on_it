import 'package:flutter_test/flutter_test.dart';
import 'package:im_on_it/domain/enums/time_span_enum.dart';

void main() {
  group('TimeSpanEnum tests', () {
    test('Enum name, value and byName', () {
      var testEnum = TimeSpanEnum.d;
      expect(testEnum.value,1);
      expect(testEnum.toString(),'TimeSpanEnum.d');

      var testEnumByName  = TimeSpanEnum.values.byName('d');
      expect(testEnumByName.value,1);

      var enumName = 'm3';
      testEnumByName  = TimeSpanEnum.values.byName(enumName);
      expect(testEnumByName.value,90);

    });
  });
}