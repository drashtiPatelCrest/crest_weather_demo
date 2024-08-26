import 'package:crest_weather_demo/models/weather_model.dart';
import 'package:crest_weather_demo/widgets/next_five_weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:intl/intl.dart';

void main() {
  testWidgets('NextFiveDayWidget', (WidgetTester tester) async {
    WeatherModel weatherModel = WeatherModel(
      list: [
        WeatherList(dtTxt: '2024-08-01 15:00:00', main: Main(tempMin: 280, tempMax: 290)),
        WeatherList(dtTxt: '2024-08-15 06:00:00', main: Main(tempMin: 285, tempMax: 295)),
        WeatherList(dtTxt: '2024-08-25 08:00:00', main: Main(tempMin: 275, tempMax: 285)),
        WeatherList(dtTxt: '2024-08-30 13:00:00', main: Main(tempMin: 275, tempMax: 285)),
        WeatherList(dtTxt: '2024-08-31 14:00:00', main: Main(tempMin: 275, tempMax: 285)),
        WeatherList(dtTxt: '2024-08-31 16:00:00', main: Main(tempMin: 275, tempMax: 285)),
      ],
    );

    await tester.pumpWidget(MaterialApp(
      home: NextFiveWeather(weatherModel: weatherModel),
    ));

    expect(find.text('Next ${weatherModel.list!.length} Days'), findsOneWidget);

    for (var weather in weatherModel.list!) {
      String dateString = DateFormat('MMM dd').format(DateTime.now());
      expect(find.text(dateString), findsOneWidget);
      expect(find.text('${(weather.main!.tempMin! - 273.15).toStringAsFixed(0)}\u00B0'), findsOneWidget);
      expect(find.text('${(weather.main!.tempMax! - 273.15).toStringAsFixed(0)}\u00B0'), findsOneWidget);
    }
  });

  testWidgets('NextFiveDayWidget handles null weatherModel', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: NextFiveWeather(weatherModel: null),
    ));

    expect(find.byType(Container), findsOneWidget);
  });
}
