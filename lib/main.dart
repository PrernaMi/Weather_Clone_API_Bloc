import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_api_clone/bloc/weather_bloc.dart';
import 'package:weather_api_clone/data/remote/api_helper.dart';
import 'package:weather_api_clone/screens/home_page.dart';

void main() {
  runApp(BlocProvider(create: (context){
    return WeatherBloc(apiHelper: APIHelper());
  },child: MyApp(),));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  LatLng? currentPos;
  SharedPreferences? prefs;
  bool locationOn = false;

  @override
  void initState() {
    // getCurrentLocation(context: context);
    super.initState();
  }

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

  void getCurrentLocation({required BuildContext context}) async {
    bool isCheck = await checkBeforeCallingPermission(context: context);
    if (isCheck) {
      locationOn = true;
      var currPos = await Geolocator.getCurrentPosition();
      currentPos = LatLng(currPos.latitude, currPos.longitude);
      prefs!.setDouble("Lat", currentPos!.latitude);
      prefs!.setDouble("Longi", currentPos!.longitude);
      setState(() {

      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text("Don't have the proper permission to access loaction..")));
    }
  }

  Future<bool> checkBeforeCallingPermission({required BuildContext context}) async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Permission is denied")));
          return false;
        } else if (permission == LocationPermission.deniedForever) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  "Location permissions are permanently denied, we cannot request permissions.")));
          return false;
        } else
          return true;
      } else {
        return true;
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Location services are disabled..")));
      return false;
    }
  }
}
