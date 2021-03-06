import 'package:weather_app/Model/weather_model.dart';

abstract class WeatherState {}

class WeatherInitialState extends WeatherState {}

class WeatherLodingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final WeatherModel weather;

  WeatherLoadedState(this.weather);
}

class WeatherFailureState extends WeatherState {
  final Exception error;
  WeatherFailureState(this.error);
}
