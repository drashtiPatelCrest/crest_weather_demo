part of 'weather_bloc.dart';

enum WeatherStateStatus {
  location,
  loadingLocation,
  locationFailed,
  loading,
  loaded,
  failed,
  error,
}

@immutable
class WeatherState extends Equatable {
  final WeatherStateStatus status;
  final WeatherModel? weatherModel;
  final Position? position;

  const WeatherState({
    required this.status,
    required this.weatherModel,
    this.position,
  });

  WeatherState copyWith({
    WeatherStateStatus? status,
    WeatherModel? weatherModel,
    Position? position,
  }) =>
      WeatherState(
        status: status ?? this.status,
        weatherModel: weatherModel ?? this.weatherModel,
        position: position ?? this.position,
      );

  @override
  List<Object?> get props => [status, weatherModel, position];

  Map<String, dynamic> toMap() {
    return {
      'status': status.toString(),
      'weatherModel': weatherModel,
      'position': position,
    };
  }

  factory WeatherState.fromMap(Map<String, dynamic> map) {
    return WeatherState(
      status: map['status'] ?? WeatherStateStatus.loading,
      weatherModel: map['weatherModel'],
      position: map['position'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherState.fromJson(String source) => WeatherState.fromMap(json.decode(source));

  @override
  String toString() => 'WeatherState(status: $status, weatherModel: $weatherModel)';
}
