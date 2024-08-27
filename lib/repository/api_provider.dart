import 'package:crest_weather_demo/models/weather_model.dart';
import 'package:crest_weather_demo/utils/api_key_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

import '../serializer/serializers.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url = 'https://api.openweathermap.org/data/2.5/forecast?';

  Future<WeatherModel> fetchCovidWeatherInfo(
      {required Position position}) async {
    try {
      _dio.interceptors.add(DioInterceptor());
      print('$_url&lat=${position.latitude}&lon=${position.longitude}');
      Response response = await _dio
          .get('$_url&lat=${position.latitude}&lon=${position.longitude}');
      WeatherModel? weather =
          serializers.deserializeWith(WeatherModel.serializer, response.data);
      return weather!;
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      throw Exception('Failed to load data');
    }
  }

  Future<Position?> getCurrentLocation() async {
    bool servicePermission = await Geolocator.isLocationServiceEnabled();

    if (!servicePermission) {
      print("Service Disabled");
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    try {
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      return null;
    }
  }
}
