import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Model/weather_model.dart';
import 'package:weather_app/Model/weather_repo.dart';
import 'Screens/search_screen.dart';
import 'BLoC/weather_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Weather App",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.orange[100],
        appBar: AppBar(
          title: Text("Weather App"),
        ),
        body: BlocProvider(
          create: (context) => WeatherBloc(WeatherRepo()),
          child: WeatherScreen(),
        ),
      ),
      theme: ThemeData(primaryColor: Colors.blue[100]),
    );
  }
}
