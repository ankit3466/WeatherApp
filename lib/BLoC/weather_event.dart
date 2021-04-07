import 'package:bloc/bloc.dart';

abstract class WeatherEvent {}

class GetWeatherEvent extends WeatherEvent {
  String city;
  GetWeatherEvent(this.city);
}

class GetCurrentLocationWeatherEvent extends WeatherEvent {}

class ResetWeatherEvent extends WeatherEvent {}
