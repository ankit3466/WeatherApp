import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/LocationUtils/Exceptions.dart';

class WeatherRepo {
  String API_KEY = "3f83b448bd05736b0fb482c24609e2f6";

  Future<WeatherModel> getWeather(String cityName) async {
    var url =
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=$API_KEY";
    print("before fatching");
    try {
      var response = await http.get(url);
      if (response.statusCode != 200) {
        throw ServiceException(
            "No matching Location found. Please provide the right city name to search weather.");
      }
      return getdatafromjson(response.body);
    } catch (e) {
      throw InternetException(
          "Unknown Error! Check your Internet Connection !!");
    }
  }

  Future<Position> getLocation() async {
    LocationPermission permission;
    if (await Geolocator.isLocationServiceEnabled()) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
        return position;
      } else {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.always &&
            permission != LocationPermission.whileInUse) {
          throw PermissionDenied(
              "Go to app setting and enable the location permission to use the service.");
        } else {
          Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best);
          return position;
        }
      }
    } else {
      throw MobilePermissionException("Please enable GPS of the device.");
    }
  }

  Future<WeatherModel> getCurrentLocationWeather() async {
    Position pos = await getLocation();
    var url =
        "https://api.openweathermap.org/data/2.5/weather?lat=${pos.latitude}&lon=${pos.longitude}&units=metric&appid=$API_KEY";

    try {
      var response = await http.get(url);
      if (response.statusCode != 200) {
        throw ServiceException(
            "No matching Location found. Please provide the right city name to search weather.");
      }
      return getdatafromjson(response.body);
    } catch (e) {
      throw InternetException(
          "Unknown Error! Check your Internet Connection !!");
    }
  }

  WeatherModel getdatafromjson(final response) {
    final jsondecoded = json.decode(response) as Map<String, dynamic>;

    return WeatherModel.fromJson(jsondecoded);
  }
}
