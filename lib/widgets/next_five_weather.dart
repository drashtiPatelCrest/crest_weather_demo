import 'package:crest_weather_demo/constants/enum_constants.dart';
import 'package:crest_weather_demo/models/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/date_time_util.dart';
import 'medium_text.dart';

class NextFiveWeather extends StatelessWidget {
  WeatherModel? weatherModel;

  NextFiveWeather({super.key, required this.weatherModel});

  @override
  Widget build(BuildContext context) {
    if (weatherModel == null) {
      return const Center(child: Text('Future weather info not found'));
    }
    List<Forecast> nextFive =
        getNextFiveDays(weatherModel?.list.toList() ?? []);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: MediumText(text: 'Next ${nextFive.length} Days'),
              ),
              Expanded(
                flex: 1,
                child: MediumText(
                  text: 'Min',
                  textAlign: TextAlign.end,
                ),
              ),
              Expanded(
                flex: 1,
                child: MediumText(
                  text: 'Max',
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: ListView.builder(
            itemCount: nextFive.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: MediumText(
                        text: DateTimeUtil.convertShortDate(
                            nextFive[index].dt_txt),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: MediumText(
                        text: nextFive[index].main!.temp_min!.toCelsiusString(),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: MediumText(
                        text: nextFive[index].main!.temp_max!.toCelsiusString(),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  List<Forecast> getNextFiveDays(List<Forecast> forecastList) {
    if (forecastList == null) return [];

    String todayString = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var otherDates = forecastList!.where((element) =>
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
