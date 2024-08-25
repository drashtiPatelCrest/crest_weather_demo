import 'dart:async';

import 'package:crest_weather_demo/bloc/weather_bloc.dart';
import 'package:crest_weather_demo/models/weather_model.dart';
import 'package:crest_weather_demo/utils/date_time_util.dart';
import 'package:crest_weather_demo/utils/internet_cubit.dart';
import 'package:crest_weather_demo/widgets/medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<StatefulWidget> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late bool servicePermission = false;
  late LocationPermission permission;
  bool isGotLocation = false;

  Future<Position> _getCurrentLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();

    if (!servicePermission) {
      print("Service Disabled");
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    context.read<WeatherBloc>().add(const GetCurrentLocation());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: SizedBox.shrink(),
        ),
        body: BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
          if (state.status == WeatherStateStatus.loadingLocation) {
            return _loaderView();
          } else if (state.status == WeatherStateStatus.location) {
            context.read<WeatherBloc>().add(FetchWeatherDetails(lat: state.position!.latitude.toString(), lon: state.position!.longitude.toString()));
            return _loaderView();
          } else if (state.status == WeatherStateStatus.loaded) {
            return _weatherInfoView(state.weatherModel);
          } else {
            return _loaderView();
          }
        }),
      ),
    );
  }

  Widget _weatherInfoView(WeatherModel? weatherModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: _todayInfoWidget(weatherModel),
          ),
          Expanded(
            flex: 1,
            child: _nextFiveDayWidget(weatherModel),
          ),
        ],
      ),
    );
  }

  Widget _loaderView() {
    return const Center(child: CircularProgressIndicator());
  }

  String _kelvinToCelsius(num? kelvin) {
    if (kelvin == null) {
      return '-';
    }
    return '${(kelvin - 273.15).toStringAsPrecision(2)}\u00B0';
  }

  _todayInfoWidget(
    WeatherModel? weatherModel,
  ) {
    String todayString = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var todayLatest = weatherModel?.list?.lastWhere((element) => element.dtTxt != null && element.dtTxt!.contains(todayString) == true);

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // City Info
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${weatherModel?.city?.name ?? ''}, ${weatherModel?.city?.country ?? ''}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 30,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Icon(
              Icons.pin_drop,
              color: Colors.black,
              size: 35,
            ),
          ],
        ),
        Text(
          DateTimeUtil.convertDateFormat(weatherModel?.list?.first.dtTxt),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 10),
        // Degree
        Text(
          _kelvinToCelsius(todayLatest?.main?.temp ?? 0.00),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 100,
          ),
        ),
        // Description
        Text(
          '${todayLatest?.weather?.first.description}',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  _nextFiveDayWidget(WeatherModel? weatherModel) {
    String todayString = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var otherDates = weatherModel?.list?.where((element) => element.dtTxt != null && element.dtTxt!.contains(todayString) == false);
    List<WeatherList> nextFive = [];
    otherDates?.forEach((weather) {
      String dateString = weather.dtTxt!.split(' ')[0];
      if (nextFive.any((element) => element.dtTxt!.contains(dateString)) == false) {
        nextFive.add(otherDates.firstWhere((element) => element.dtTxt!.contains(dateString) == true));
      }
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: MediumText(text: 'Next 5 Days'),
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
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), borderRadius: const BorderRadius.all(Radius.circular(10))),
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
                        text: _kelvinToCelsius(nextFive[index].main?.tempMin),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: MediumText(
                        text: _kelvinToCelsius(nextFive[index].main?.tempMax),
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
