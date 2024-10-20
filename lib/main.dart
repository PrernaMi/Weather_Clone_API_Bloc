import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_api_clone/bloc/weather_bloc.dart';
import 'package:weather_api_clone/data/remote/api_helper.dart';
import 'package:weather_api_clone/screens/home_page.dart';
import 'package:weather_api_clone/screens/view_more.dart';

void main() {
  runApp(
    BlocProvider(create: (context){
      return WeatherBloc(apiHelper: APIHelper());
    },child: MyApp(),)
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
