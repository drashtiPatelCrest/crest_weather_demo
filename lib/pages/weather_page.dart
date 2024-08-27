import 'dart:async';

import 'package:crest_weather_demo/bloc/weather_bloc.dart';
import 'package:crest_weather_demo/models/weather_model.dart';
import 'package:crest_weather_demo/utils/date_time_util.dart';
import 'package:crest_weather_demo/constants/enum_constants.dart';
import 'package:crest_weather_demo/widgets/next_five_weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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

  @override
  void initState() {
    getCurrentLocation();
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
        body: BlocBuilder<WeatherBloc, WeatherState>(
            bloc: context.read<WeatherBloc>(),
            builder: (context, state) {
              if (state.status == WeatherStateStatus.loadingLocation) {
                return _loaderView();
              } else if (state.status == WeatherStateStatus.locationFailed) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                        'Please turn on GPS \n allow location permission and try again!',
                        textAlign: TextAlign.center),
                    OutlinedButton(
                        onPressed: () => context
                            .read<WeatherBloc>()
                            .add(const GetCurrentLocation()),
                        child: const Text('Try Again')),
                  ],
                ));
              } else if (state.status == WeatherStateStatus.location) {
                context
                    .read<WeatherBloc>()
                    .add(FetchWeatherDetails(position: state.position));
                return _loaderView();
              } else if (state.status == WeatherStateStatus.loaded) {
                return _weatherInfoView(state.weatherModel);
              } else if (state.status == WeatherStateStatus.failed) {
                return const Center(child: Text('No weather records found!'));
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
            child: _todayWeatherInfoWidget(weatherModel),
          ),
          Expanded(
            flex: 1,
            child: NextFiveWeather(weatherModel: weatherModel),
          ),
        ],
      ),
    );
  }

  Widget _loaderView() {
    return const Center(child: CircularProgressIndicator());
  }

  _todayWeatherInfoWidget(
    WeatherModel? weatherModel,
  ) {
    String todayString = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var todayLatest = weatherModel?.list.lastWhere((element) =>
        element.dt_txt != null &&
        element.dt_txt!.contains(todayString) == true);

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // City Info
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${weatherModel?.city.name ?? ''}, ${weatherModel?.city.country ?? ''}',
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
          'Last update, ${DateTimeUtil.convertDateFormat(weatherModel?.list.first.dt_txt)}',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 10),
        // Degree
        Text(
          todayLatest!.main!.temp!.toCelsiusString(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 100,
          ),
        ),
        // Description
        Text(
          '${todayLatest.weather?.first.description}',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  void getCurrentLocation() async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
    if (isConnected) {
      context.read<WeatherBloc>().add(const GetCurrentLocation());
    }
  }
}
