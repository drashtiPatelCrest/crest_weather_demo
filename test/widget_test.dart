import 'package:crest_weather_demo/models/weather_model.dart';
import 'package:crest_weather_demo/widgets/next_five_weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  group('NextFiveWeather Widget Tests', () {
    testWidgets('Displays error message when weatherModel is null',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(MaterialApp(home: NextFiveWeather(weatherModel: null)));
      expect(find.text('Future weather info not found'), findsOneWidget);
    });

    testWidgets('Displays correct forecast when weatherModel is provided',
        (WidgetTester tester) async {
      // Mock WeatherModel data
      var mockWeatherModel = WeatherModel((b) => b
        ..list.addAll([
          Forecast((f) => f
            ..dt_txt = DateFormat('yyyy-MM-dd hh:mm:ss')
                .format(DateTime.now().add(Duration(days: 1)))
            ..main.update((m) => m
              ..temp_min = 280
              ..temp = 285
              ..feels_like = 290
              ..pressure = 1000
              ..humidity = 50
              ..temp_kf = 5
              ..temp_max = 300)),
          Forecast((f) => f
            ..dt_txt = DateFormat('yyyy-MM-dd hh:mm:ss')
                .format(DateTime.now().add(Duration(days: 2)))
            ..main.update((m) => m
              ..temp_min = 281
              ..feels_like = 295
              ..pressure = 1001
              ..humidity = 51
              ..temp_kf = 6
              ..temp = 290
              ..temp_max = 305)),
        ]));

      await tester.pumpWidget(
          MaterialApp(home: NextFiveWeather(weatherModel: mockWeatherModel)));
    });
  });
}
