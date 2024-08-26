import 'package:crest_weather_demo/constants/enum_constants.dart';
import 'package:flutter_test/flutter_test.dart';
void main() {
  group('TemperatureConversion', () {
    test('Converts Kelvin to Celsius correctly', () {
      expect((273.15 as num).toCelsiusString(), '0\u00B0');
      expect((293.15 as num).toCelsiusString(), '20\u00B0');
      expect((300.0 as num).toCelsiusString(), '26\u00B0');
      expect((0.0 as num).toCelsiusString(), '-273\u00B0');
    });

    test('Negative Kelvin values', () {
      expect((-100.0 as num).toCelsiusString(), '-373\u00B0');
    });
  });
}
