import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_api_clone/bloc/weather_bloc.dart';
import 'package:weather_api_clone/bloc/weather_events.dart';
import 'package:weather_api_clone/bloc/weather_state.dart';
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MediaQueryData?mqData;
  SharedPreferences? prefs;
  double? lat;
  double? logi;

  @override
  void initState() {
    // getLocation();
    context
        .read<WeatherBloc>()
        .add(GetWeatherEvent(lat: 28.6692, lon: 77.4538));
    super.initState();
  }

  void getLocation() async {
    prefs = await SharedPreferences.getInstance();
    lat = prefs!.getDouble("Lat");
    logi = prefs!.getDouble("Longi");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    mqData = MediaQuery.of(context);
    return Scaffold(
      body: BlocBuilder<WeatherBloc, BlocState>(builder: (_, state) {
        if (state is BlocLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is BlocErrorState) {
          return Center(child: Text(state.errorMsg!));
        }
        if (state is BlocLoadedState) {
          int timestamp = state.weather!.dt!;
          DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp*1000);
          String formattedDate = DateFormat('EEE, hh:mm').format(date);
          var data = state.weather;
          double kelvinTemp = state.weather!.main!.temp!;
          double kelvinFeels = state.weather!.main!.feelsLike!-273.15;
          double kelvinMax = state.weather!.main!.tempMax!-273.15;
          double kelvinMin = state.weather!.main!.tempMin!-273.15;
          double windSpeedMetersPerSecond = state.weather!.wind!.speed!;
          double windSpeedKilometersPerHour = windSpeedMetersPerSecond * 3.6;
          double celsius = kelvinTemp - 273.15;
          int visibility = state.weather!.visibility!;
          int visibleKm = visibility~/1000;
          return Stack(
            children: [
              Positioned.fill(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    "assets/images/img.png", fit: BoxFit.cover,
                    color: Colors.white.withOpacity(0.5),
                    // Color to blend
                    colorBlendMode: BlendMode.lighten,
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: mqData!.size.height*0.08,
                  ),
                  SizedBox(
                    height: mqData!.size.height*0.06,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(data!.name!,style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),),
                        Icon(Icons.location_on)
                      ],
                    ),
                  ),
                  Text(formattedDate),
                  SizedBox(
                    height: mqData!.size.height*0.12,
                  ),
                  Text('${data.weather![0].main}',style: TextStyle(
                    fontSize: 25
                  ),),
                  Text('${celsius.toStringAsFixed(2)}°C',style: TextStyle(
                    fontSize: 70,
                    fontWeight: FontWeight.bold
                  ),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Feels like: ${kelvinFeels.toStringAsFixed(0)}°",style: TextStyle(fontSize: 15),),
                      Icon(Icons.arrow_upward,color: Colors.red,),
                      Text(" ${kelvinMax.toStringAsFixed(0)}°",style: TextStyle(fontSize: 15),),
                      Icon(Icons.arrow_downward,color: Colors.blueAccent,),
                      Text(" ${kelvinMin.toStringAsFixed(0)}°",style: TextStyle(fontSize: 15),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Icon(Icons.thunderstorm_outlined),
                      Text(' ${windSpeedKilometersPerHour.toStringAsFixed(2)}km/h'),
                      SizedBox(width: 10,),
                      Icon(Icons.water_drop_outlined),
                      Text(' ${state.weather!.main!.humidity}%')
                  ],),
                  Text("Visibility around: ${visibleKm} km"),
                ],
              )
            ],
          );
          // return ListView.builder(
          //   itemCount: state.weather!.weather!.length,
          //     itemBuilder: (_,index){
          //     var data = state.weather!.weather!;
          //   return ListTile(
          //     title: Text(data[index].main!),
          //     subtitle: Text(data[index].description!),
          //   );
          // });
        }
        return Container();
      }),
      /* body: GoogleMap(
        mapType: MapType.satellite,
          initialCameraPosition: CameraPosition(
              target: LatLng(lat!,logi!),
              bearing: 192.99,
              tilt: 59.44,
              zoom: 50.14)),*/
    );
  }
}
