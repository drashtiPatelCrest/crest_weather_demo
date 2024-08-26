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
    List<WeatherList> nextFive = weatherModel?.list?.getNextFiveDays() ?? [];
    ;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.7), borderRadius: const BorderRadius.all(Radius.circular(10))),
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
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.7), borderRadius: const BorderRadius.all(Radius.circular(10))),
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
                        text: DateTimeUtil.convertShortDate(nextFive[index].dtTxt),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: MediumText(
                        text: nextFive[index].main!.tempMin!.toCelsiusString(),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: MediumText(
                        text: nextFive[index].main!.tempMax!.toCelsiusString(),
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
}
