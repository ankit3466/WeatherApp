import 'package:weather_app/BLoC/weather_event.dart';
import 'package:weather_app/BLoC/weather_state.dart';
import 'package:weather_app/Model/weather_model.dart';
import 'package:weather_app/Model/weather_repo.dart';

import 'weather_event.dart';
import 'weather_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepo weatherrepo;
  WeatherBloc(this.weatherrepo) : super(WeatherInitialState());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is GetWeatherEvent) {
      print("Inside event");
      yield WeatherLodingState();
      try {
        print("Inside try");
        final weather = await weatherrepo.getWeather(event.city);
        print("Inside weather");
        yield WeatherLoadedState(weather);
      } catch (error) {
        print("Error, $error");
        yield WeatherFailureState(error);
      }
    } else if (event is GetCurrentLocationWeatherEvent) {
      print("Inside Location");
      yield WeatherLodingState();
      try {
        print("Inside loc try");
        final WeatherModel weather =
            await weatherrepo.getCurrentLocationWeather();
        print("Weather");
        yield WeatherLoadedState(weather);
      } catch (error) {
        //print(error);
        yield WeatherFailureState(error);
      }
    } else if (event is ResetWeatherEvent) {
      yield WeatherInitialState();
    }
  }
}
