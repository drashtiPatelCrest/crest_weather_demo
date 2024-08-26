import 'package:crest_weather_demo/models/weather_model.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url = 'https://api.openweathermap.org/data/2.5/forecast?';

  Future<WeatherModel> fetchCovidWeatherInfo({required Position position}) async {
    try {
      Response response = await _dio.get('$_url&lat=${position.latitude}&lon=${position.longitude}&appid=37ea9939152496e5de6ca532f93817fd');
      return WeatherModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return WeatherModel.withError("Data not found / Connection issue");
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
