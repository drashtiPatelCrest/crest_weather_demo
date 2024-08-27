import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/standard_json_plugin.dart';
import '../models/weather_model.dart';

part 'serializers.g.dart';

@SerializersFor([
  WeatherModel,
  Forecast,
  MainData,
  WeatherDescription,
  Clouds,
  Wind,
  Rain,
  Sys,
  City,
  Coord,
  // Any other models
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
