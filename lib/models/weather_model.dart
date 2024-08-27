import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

part 'weather_model.g.dart';

abstract class WeatherModel
    implements Built<WeatherModel, WeatherModelBuilder> {
  static Serializer<WeatherModel> get serializer => _$weatherModelSerializer;

  String get cod;
  int get message;
  int get cnt;
  BuiltList<Forecast> get list;
  City get city;

  WeatherModel._();
  factory WeatherModel([void Function(WeatherModelBuilder) updates]) =
      _$WeatherModel;
}

abstract class Forecast implements Built<Forecast, ForecastBuilder> {
  static Serializer<Forecast> get serializer => _$forecastSerializer;

  int get dt;
  MainData get main;
  BuiltList<WeatherDescription> get weather;
  Clouds get clouds;
  Wind get wind;
  int get visibility;
  double get pop;
  Rain get rain;
  Sys get sys;
  String get dt_txt;

  Forecast._();
  factory Forecast([void Function(ForecastBuilder) updates]) = _$Forecast;
}

abstract class MainData implements Built<MainData, MainDataBuilder> {
  static Serializer<MainData> get serializer => _$mainDataSerializer;

  double get temp;
  double get feels_like;
  double get temp_min;
  double get temp_max;
  int get pressure;
  int get humidity;
  double get temp_kf;

  MainData._();
  factory MainData([void Function(MainDataBuilder) updates]) = _$MainData;
}

abstract class WeatherDescription
    implements Built<WeatherDescription, WeatherDescriptionBuilder> {
  static Serializer<WeatherDescription> get serializer =>
      _$weatherDescriptionSerializer;

  int get id;
  String get main;
  String get description;
  String get icon;

  WeatherDescription._();
  factory WeatherDescription(
          [void Function(WeatherDescriptionBuilder) updates]) =
      _$WeatherDescription;
}

abstract class Clouds implements Built<Clouds, CloudsBuilder> {
  static Serializer<Clouds> get serializer => _$cloudsSerializer;

  int get all;

  Clouds._();
  factory Clouds([void Function(CloudsBuilder) updates]) = _$Clouds;
}

abstract class Wind implements Built<Wind, WindBuilder> {
  static Serializer<Wind> get serializer => _$windSerializer;

  double get speed;
  int get deg;
  double get gust;

  Wind._();
  factory Wind([void Function(WindBuilder) updates]) = _$Wind;
}

abstract class Rain implements Built<Rain, RainBuilder> {
  static Serializer<Rain> get serializer => _$rainSerializer;

  @BuiltValueField(wireName: '3h')
  double? get threeHour; // Updated for null safety

  Rain._();
  factory Rain([void Function(RainBuilder) updates]) = _$Rain;
}

abstract class Sys implements Built<Sys, SysBuilder> {
  static Serializer<Sys> get serializer => _$sysSerializer;

  String get pod;

  Sys._();
  factory Sys([void Function(SysBuilder) updates]) = _$Sys;
}

abstract class City implements Built<City, CityBuilder> {
  static Serializer<City> get serializer => _$citySerializer;

  int get id;
  String get name;
  Coord get coord;
  String get country;
  int get population;
  int get timezone;
  int get sunrise;
  int get sunset;

  City._();
  factory City([void Function(CityBuilder) updates]) = _$City;
}

abstract class Coord implements Built<Coord, CoordBuilder> {
  static Serializer<Coord> get serializer => _$coordSerializer;

  double get lat;
  double get lon;

  Coord._();
  factory Coord([void Function(CoordBuilder) updates]) = _$Coord;
}
