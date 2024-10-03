import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_api_clone/bloc/weather_bloc.dart';
import 'package:weather_api_clone/bloc/weather_events.dart';
import 'package:weather_api_clone/bloc/weather_state.dart';
import 'package:weather_api_clone/provider/lat_lon_provider.dart';
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MediaQueryData? mqData;

  @override
  void initState() {
    getCurrentLocation(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mqData = MediaQuery.of(context);
    return Scaffold(
      body: BlocBuilder<WeatherBloc, BlocState>(
        builder: (context, state) {
          if (state is BlocLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is BlocLoadedState) {
            // Process weather data
            int timestamp = state.weather!.dt!;
            DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
            String formattedDate = DateFormat('EEE, hh:mm').format(date);
            var data = state.weather;
            double kelvinTemp = data!.main!.temp!;
            double celsius = kelvinTemp - 273.15;
            double kelvinFeels = data.main!.feelsLike! - 273.15;
            double kelvinMax = data.main!.tempMax! - 273.15;
            double kelvinMin = data.main!.tempMin! - 273.15;
            double windSpeedMetersPerSecond = data.wind!.speed!;
            double windSpeedKilometersPerHour = windSpeedMetersPerSecond * 3.6;
            int visibility = data.visibility!;
            int visibleKm = visibility ~/ 1000;

            // Build the weather display UI
            return Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      "assets/images/img.png",
                      fit: BoxFit.cover,
                      color: Colors.white.withOpacity(0.5),
                      colorBlendMode: BlendMode.lighten,
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: mqData!.size.height * 0.08),
                    SizedBox(
                      height: mqData!.size.height * 0.06,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data.name!,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          Icon(Icons.location_on),
                        ],
                      ),
                    ),
                    Text(formattedDate),
                    SizedBox(height: mqData!.size.height * 0.12),
                    Text(
                      '${data.weather![0].main}',
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      '${celsius.toStringAsFixed(2)}°C',
                      style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Feels like: ${kelvinFeels.toStringAsFixed(0)}°", style: TextStyle(fontSize: 15)),
                        Icon(Icons.arrow_upward, color: Colors.red),
                        Text(" ${kelvinMax.toStringAsFixed(0)}°", style: TextStyle(fontSize: 15)),
                        Icon(Icons.arrow_downward, color: Colors.blueAccent),
                        Text(" ${kelvinMin.toStringAsFixed(0)}°", style: TextStyle(fontSize: 15)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.thunderstorm_outlined),
                        Text(' ${windSpeedKilometersPerHour.toStringAsFixed(2)} km/h'),
                        SizedBox(width: 10),
                        Icon(Icons.water_drop_outlined),
                        Text(' ${data.main!.humidity}%'),
                      ],
                    ),
                    Text("Visibility around: ${visibleKm} km"),
                  ],
                ),
              ],
            );
          }

          return Container();
        },
      ),
    );
  }
  void getCurrentLocation({required BuildContext context}) async {
    bool isCheck = await checkBeforeCallingPermission(context: context);
    if (isCheck) {
      var currPos = await Geolocator.getCurrentPosition();
      context.read<WeatherBloc>().add(GetWeatherEvent(lat: currPos.latitude, lon: currPos.longitude));
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

