// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers = (new Serializers().toBuilder()
      ..add(City.serializer)
      ..add(Clouds.serializer)
      ..add(Coord.serializer)
      ..add(Forecast.serializer)
      ..add(MainData.serializer)
      ..add(Rain.serializer)
      ..add(Sys.serializer)
      ..add(WeatherDescription.serializer)
      ..add(WeatherModel.serializer)
      ..add(Wind.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Forecast)]),
          () => new ListBuilder<Forecast>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(WeatherDescription)]),
          () => new ListBuilder<WeatherDescription>()))
    .build();

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
