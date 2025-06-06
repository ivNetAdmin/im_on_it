import 'package:flutter_test/flutter_test.dart';
import 'package:im_on_it/domain/enums/time_span_enum.dart';

void main() {
  group('TimeSpanEnum tests', () {
    test('Enum name, value and byName', () {
      var testEnum = TimeSpanEnum.d3;
      expect(testEnum.value,3);
      expect(testEnum.toString(),'TimeSpanEnum.d3');

      var testEnumByName  = TimeSpanEnum.values.byName('d3');
      expect(testEnumByName.value,3);

      var enumName = 'm3';
      testEnumByName  = TimeSpanEnum.values.byName(enumName);
      expect(testEnumByName.value,90);

    });
  });
}