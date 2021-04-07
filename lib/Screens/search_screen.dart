import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/BLoC/weather_bloc.dart';
import 'package:weather_app/BLoC/weather_event.dart';
import 'package:weather_app/BLoC/weather_state.dart';
import 'package:weather_app/widgets/weatherloading.dart';
import 'package:weather_app/widgets/textbutton.dart';
import 'package:weather_app/Screens/weather_screen.dart';
import 'package:weather_app/widgets/snackbar.dart';
import 'package:weather_app/LocationUtils/Exceptions.dart';

class weather extends StatefulWidget {
  @override
  _weatherState createState() => _weatherState();
}

class _weatherState extends State<weather> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherInitialState) {
          return SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.fromLTRB(
                  size.width * 0.15, size.height * 0.2, size.width * 0.15, 0),
              child: Column(
                children: [
                  TextField(
                    controller: textController,
                    autofocus: false,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      labelStyle: TextStyle(fontSize: 20),
                      hintStyle: TextStyle(color: Colors.white),
                      //icon: Icon(Icons.search),
                      labelText: "Search",
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Container(
                    width: double.infinity,
                    child: RaisedButton.icon(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      color: Colors.blue,
                      //hoverColor: Colors.yellowAccent,
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      label: Text(
                        "Get Weather",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        if (textController.text.length == 0) {
                          ShowsnackBar(context);
                          return;
                        }
                        BlocProvider.of<WeatherBloc>(context)
                            .add(GetWeatherEvent(textController.text));
                        textController.clear();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    width: double.infinity,
                    child: RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        color: Colors.blue,
                        //hoverColor: Colors.yellowAccent,
                        icon: Icon(
                          Icons.location_searching,
                          color: Colors.white,
                        ),
                        label: Text(
                          "Weather",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          BlocProvider.of<WeatherBloc>(context)
                              .add(GetCurrentLocationWeatherEvent());
                        }),
                  ),
                ],
              ),
            ),
          );
        } else if (state is WeatherLodingState) {
          return CenterCircularProgressIndicator();
        } else if (state is WeatherLoadedState) {
          return ShowWeatherInfo(state.getweather);
        } else if (state is WeatherFailureState) {
          if (state.error.runtimeType == PermissionDenied) {
            return TextWithButton(
              text: state.error.toString(),
              style: TextStyle(fontSize: 30),
              handler: () => BlocProvider.of<WeatherBloc>(context)
                  .add(ResetWeatherEvent()),
              error: "AppSetting",
            );
          } else if (state.error.runtimeType == PermissionDeniedPermanently) {
            return TextWithButton(
              text: state.error.toString(),
              style: TextStyle(fontSize: 30),
              handler: () => BlocProvider.of<WeatherBloc>(context)
                  .add(ResetWeatherEvent()),
              error: "LocationSetting",
            );
          } else if (state.error.runtimeType == ServiceException) {
            return TextWithButton(
              text: state.error.toString(),
              style: TextStyle(fontSize: 30),
              handler: () => BlocProvider.of<WeatherBloc>(context)
                  .add(ResetWeatherEvent()),
              error: "",
            );
          } else {
            //ShowsnackBar(context);
            return TextWithButton(
              text: "Unknown Error! Check your Internet Connection !!",
              style: TextStyle(fontSize: 30),
              handler: () => BlocProvider.of<WeatherBloc>(context)
                  .add(ResetWeatherEvent()),
              error: "",
            );
          }
        } else {
          return Scaffold();
        }
      },
    );
  }
}
