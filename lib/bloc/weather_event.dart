part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class FetchWeatherDetails extends WeatherEvent {
  final String lat;
  final String lon;

  const FetchWeatherDetails({required this.lat, required this.lon});
}

class GetCurrentLocation extends WeatherEvent {
  const GetCurrentLocation();
}
