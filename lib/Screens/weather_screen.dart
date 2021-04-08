import 'package:flutter/material.dart';
import 'package:weather_app/Model/weather_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/BLoC/weather_bloc.dart';
import 'package:weather_app/BLoC/weather_event.dart';

class ShowWeatherInfo extends StatelessWidget {
  final WeatherModel _weather;

  ShowWeatherInfo(this._weather);

  Widget getWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: const [Color(0xffFFF3B0), Color(0xffCA26FF)]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        child: Text(
                          _weather.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                ),
                FittedBox(
                  child: Text(
                    '${_weather.temp} \u2103',
                    style: TextStyle(fontSize: 70),
                  ),
                ),
                Text(
                  'Humidity: ${_weather.humidity}%',
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Pressure: ${_weather.pressure} hPa',
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  height: 10,
                ),
                Image.network(
                    "http://openweathermap.org/img/wn/${_weather.icon}@2x.png"),
                SizedBox(
                  height: 5,
                ),
                FittedBox(
                  child: Text(
                    _weather.description,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                width: double.infinity,
                height: 50,
                child: FlatButton(
                  onPressed: () {
                    BlocProvider.of<WeatherBloc>(context)
                        .add(ResetWeatherEvent());
                  },
                  color: Colors.lightBlue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      Text(
                        " Search",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return isLandScape
        ? SingleChildScrollView(
            child: getWidget(context),
          )
        : getWidget(context);
  }
}
