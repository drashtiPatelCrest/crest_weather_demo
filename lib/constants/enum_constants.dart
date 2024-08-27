import 'package:crest_weather_demo/models/weather_model.dart';
import 'package:intl/intl.dart';

enum ConnectionType {
  Wifi,
  Mobile,
  None,
}

extension TemperatureConversion on num {
  String toCelsiusString() {
    if (this < 0) {
      return 'Invalid';
    }
    if (this == 0) {
      return '-273\u00B0';
    }
    final celsius = this - 273.15;
    return '${celsius.toStringAsPrecision(2)}\u00B0';
  }
}

extension WeatherListExtension on List<Forecast>? {
  List<Forecast> getNextFiveDays() {
    if (this == null) return [];

    String todayString = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var otherDates = this!.where((element) =>
        element.dt_txt != null && !element.dt_txt!.contains(todayString));
    List<Forecast> nextFive = [];
    for (var weather in otherDates) {
      String dateString = weather.dt_txt!.split(' ')[0];
      if (!nextFive.any((element) => element.dt_txt!.contains(dateString))) {
        nextFive.add(otherDates
            .lastWhere((element) => element.dt_txt!.contains(dateString)));
      }
    }
    return nextFive;
  }
}
