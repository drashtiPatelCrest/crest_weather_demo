part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class FetchWeatherDetails extends WeatherEvent {
  final Position? position;

  const FetchWeatherDetails({required this.position});
}

class GetCurrentLocation extends WeatherEvent {
  const GetCurrentLocation();
}
