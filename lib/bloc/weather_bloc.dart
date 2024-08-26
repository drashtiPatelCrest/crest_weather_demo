import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:crest_weather_demo/models/weather_model.dart';
import 'package:crest_weather_demo/repository/api_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends HydratedBloc<WeatherEvent, WeatherState> {
  final ApiRepository _apiRepository = ApiRepository();

  WeatherBloc()
      : super(const WeatherState(
          status: WeatherStateStatus.loading,
          weatherModel: null,
          position: null,
        )) {
    on<FetchWeatherDetails>((event, emit) async {
      await _onWeatherApiCallEvent(event, emit);
    });
    on<GetCurrentLocation>((event, emit) async {
      await _onGetLocationInfoEvent(emit);
    });
  }

  Future<void> _onGetLocationInfoEvent(Emitter<WeatherState> emit) async {
    emit(state.copyWith(status: WeatherStateStatus.loadingLocation));

    Position? position = await _apiRepository.getCurrentLocation();
    if (position != null) {
      emit(state.copyWith(status: WeatherStateStatus.location, position: position));
    } else {
      emit(state.copyWith(status: WeatherStateStatus.locationFailed));
    }
  }

  Future<void> _onWeatherApiCallEvent(
    FetchWeatherDetails event,
    Emitter<WeatherState> emit,
  ) async {
    try {
      emit(state.copyWith(status: WeatherStateStatus.loading));
      if (event.position != null) {
        WeatherModel? weatherModel = await _apiRepository.fetchWeatherInfo(position: event.position!);
        (weatherModel != null)
            ? emit(state.copyWith(
                weatherModel: weatherModel,
                status: WeatherStateStatus.loaded,
              ))
            : emit(state.copyWith(status: WeatherStateStatus.failed, weatherModel: null));
      } else {
        emit(state.copyWith(status: WeatherStateStatus.loading, weatherModel: null));
      }
    } catch (e) {
      emit(state.copyWith(status: WeatherStateStatus.error, weatherModel: null));
    }
  }

  @override
  WeatherState? fromJson(Map<String, dynamic> json) {
    try {
      final weather = WeatherModel.fromJson(json);
      return WeatherState(
        status: WeatherStateStatus.loaded,
        weatherModel: weather,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(WeatherState state) {
    if (state.status == WeatherStateStatus.loaded) {
      return state.weatherModel?.toJson();
    } else {
      return null;
    }
  }
}
