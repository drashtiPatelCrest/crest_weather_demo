import 'package:crest_weather_demo/models/weather_model.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url = 'https://api.openweathermap.org/data/2.5/forecast?';
  final String appId = const String.fromEnvironment("APP_ID");

  Future<WeatherModel> fetchCovidWeatherInfo({required String lat,required String long}) async {
    try {
      Response response = await _dio.get('$_url&lat=$lat&lon=$long&appid=37ea9939152496e5de6ca532f93817fd');
      return WeatherModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return WeatherModel.withError("Data not found / Connection issue");
    }
  }

  Future<Position> getCurrentLocation() async {
    bool servicePermission = await Geolocator.isLocationServiceEnabled();

    if (!servicePermission) {
      print("Service Disabled");
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition();
  }

}