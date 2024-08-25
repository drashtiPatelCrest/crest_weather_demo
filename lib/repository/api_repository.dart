import 'package:crest_weather_demo/models/weather_model.dart';
import 'package:crest_weather_demo/repository/api_provider.dart';
import 'package:geolocator/geolocator.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<WeatherModel> fetchWeatherInfo({required String lat, required String long}) {
    return _provider.fetchCovidWeatherInfo(lat: lat, long: long);
  }

  Future<Position> getCurrentLocation() {
    return _provider.getCurrentLocation();
  }
}

class NetworkError extends Error {}
