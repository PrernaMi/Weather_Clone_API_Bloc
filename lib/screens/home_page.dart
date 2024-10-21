import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_api_clone/bloc/bloc_event.dart';
import 'package:weather_api_clone/screens/view_more.dart';
import 'package:weather_api_clone/utils/color_constant.dart';
import '../bloc/bloc_state.dart';
import '../bloc/weather_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MediaQueryData? mqData;
  String searchText = "";

  @override
  void initState() {
    getCurrentLocation(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    mqData = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<WeatherBloc, BlocState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is LoadedState) {
            // Process weather data
            var currWeather = state.currentWeather;
            int timestamp = state.currentWeather!.dt!;
            DateTime date =
                DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
            String formattedDate = DateFormat('EEE, hh:mm').format(date);
            double kelvinTemp = currWeather!.main!.temp!;
            double celsius = kelvinTemp - 273.15;
            double kelvinFeels = currWeather.main!.feelsLike! - 273.15;
            double kelvinMax = currWeather.main!.tempMax! - 273.15;
            double kelvinMin = currWeather.main!.tempMin! - 273.15;
            var windSpeedMetersPerSecond = currWeather.wind!.speed!;
            double windSpeedKilometersPerHour = windSpeedMetersPerSecond * 3.6;
            int visibility = currWeather.visibility!;
            int visibleKm = visibility ~/ 1000;
            // Build the weather display UI
            return Container(
              height: mqData!.size.height,
              width: mqData!.size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                ColorConst.mColor[3],
                ColorConst.mColor[2],
                ColorConst.mColor[4],
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      SizedBox(height: mqData!.size.height * 0.04),
                      SizedBox(
                        height: mqData!.size.height * 0.1,
                        width: mqData!.size.width * 0.95,
                        child: TextField(
                          onEditingComplete: () {
                            context.read<WeatherBloc>().add(
                                GetCurrentWeather(
                                    city: searchController.text.toString(),
                                    lon: 0,
                                    lat: 0));
                          },
                          controller: searchController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              hintText: "Search location",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              )),
                        ),
                      ),
                      SizedBox(height: mqData!.size.height * 0.02),
                      SizedBox(
                        height: mqData!.size.height * 0.06,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              currWeather.name!,
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
                      SizedBox(height: mqData!.size.height * 0.09),
                      Text(
                        '${currWeather.weather![0].main}',
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        '${celsius.toStringAsFixed(2)}°C',
                        style: TextStyle(
                            fontSize: 70, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              "Feels like: ${kelvinFeels.toStringAsFixed(0)}°",
                              style: TextStyle(fontSize: 15)),
                          Icon(Icons.arrow_upward, color: Colors.red),
                          Text(" ${kelvinMax.toStringAsFixed(0)}°",
                              style: TextStyle(fontSize: 15)),
                          Icon(Icons.arrow_downward,
                              color: Colors.blueAccent),
                          Text(" ${kelvinMin.toStringAsFixed(0)}°",
                              style: TextStyle(fontSize: 15)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.thunderstorm_outlined),
                          Text(
                              ' ${windSpeedKilometersPerHour.toStringAsFixed(2)} km/h'),
                          SizedBox(width: 10),
                          Icon(Icons.water_drop_outlined),
                          Text(' ${currWeather.main!.humidity}%'),
                        ],
                      ),
                      Text("Visibility around: ${visibleKm} km"),
                      SizedBox(
                        height: mqData!.size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Hourly Forcast",
                            style: TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            "72 Hours",
                            style: TextStyle(
                                color: Colors.white, fontSize: 16),
                          )
                        ],
                      ),
                      SizedBox(
                        height: mqData!.size.height * 0.02,
                      ),
                      /*--------Hourly weather------*/
                      Container(
                        height: mqData!.size.height * 0.24,
                        decoration: BoxDecoration(
                            // color: Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(10)),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.hourlyWeather!.list!.length,
                            itemBuilder: (_, index) {
                              var data = state.hourlyWeather!.list;
                              DateTime date =
                                  DateTime.fromMillisecondsSinceEpoch(
                                      data![index].dt * 1000);
                              String time =
                                  DateFormat('hh:mm').format(date);
                              String hourDate =
                                  DateFormat('dd/M').format(date);
                              double temp = data[index].main!.temp - 273.15;
                              var iconCode = data[index].weather![0].icon;
                              final iconUrl =
                                  "http://openweathermap.org/img/w/$iconCode.png";
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                width: mqData!.size.width * 0.2,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      time,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(hourDate),
                                    Image.network(iconUrl),
                                    Text('${temp.toStringAsFixed(0)}°C'),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.water_drop_outlined),
                                        Text(
                                            '${data[index].main!.humidity}%'),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: mqData!.size.height * 0.01,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return ViewMore(currentWeather: currWeather);
                          }));
                        },
                        child: Container(
                          width: mqData!.size.width,
                          height: mqData!.size.height*0.05,
                          decoration: BoxDecoration(
                            color: ColorConst.mColor[2],
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FittedBox(child: Text("View More",style: TextStyle(fontWeight: FontWeight.bold),)),
                              SizedBox(width: 10,),
                              Icon(Icons.arrow_forward_outlined)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          if (state is ErrorState) {
            return Center(child: Text(state.errorMsg!));
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
      context.read<WeatherBloc>().add(GetCurrentWeather(
          lat: currPos.latitude, lon: currPos.longitude, city: null));
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text("Don't have the proper permission to access loaction..")));
    }
  }

  Future<bool> checkBeforeCallingPermission(
      {required BuildContext context}) async {
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
