import 'package:crest_weather_demo/constants/enum_constants.dart';
import 'package:flutter_test/flutter_test.dart';
void main() {
  group('TemperatureConversion', () {
    test('converts Kelvin to Celsius correctly', () {
      expect(273.15.toCelsiusString(), '0\u00B0');
      expect(293.15.toCelsiusString(), '20\u00B0');
      expect(300.0.toCelsiusString(), '26.8\u00B0');
      expect(0.0.toCelsiusString(), '-273\u00B0');
    });

    test('handles negative Kelvin values', () {
      expect((-100.0).toCelsiusString(), '-373\u00B0');
    });
  });
}
