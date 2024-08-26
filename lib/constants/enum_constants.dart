import 'package:crest_weather_demo/models/weather_model.dart';
import 'package:intl/intl.dart';

enum ConnectionType {
  Wifi,
  Mobile,
  None,
}

extension TemperatureConversion on num {
  String toCelsiusString() {
    final celsius = this - 273.15;
    return '${celsius.toStringAsPrecision(2)}\u00B0';
  }
}

extension WeatherListExtension on List<WeatherList>? {
  List<WeatherList> getNextFiveDays() {
    if (this == null) return [];

    String todayString = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var otherDates = this!.where((element) => element.dtTxt != null && !element.dtTxt!.contains(todayString));
    List<WeatherList> nextFive = [];
    for (var weather in otherDates) {
      String dateString = weather.dtTxt!.split(' ')[0];
      if (!nextFive.any((element) => element.dtTxt!.contains(dateString))) {
        nextFive.add(otherDates.lastWhere((element) => element.dtTxt!.contains(dateString)));
      }
    }
    return nextFive;
  }
}
