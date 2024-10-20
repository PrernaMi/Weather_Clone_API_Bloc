import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_api_clone/utils/color_constant.dart';

class ViewMore extends StatelessWidget{
  var currentWeather;
  String dayMode = "Day";
  MediaQueryData?mqData;
  ViewMore({required this.currentWeather});
  @override
  Widget build(BuildContext context) {
    var iconCode = currentWeather.weather![0].icon;
    final iconUrl =
        "http://openweathermap.org/img/w/$iconCode.png";
    double temp = currentWeather.main!.temp - 273.15;
    int timestampSunrise = currentWeather!.sys!.sunrise;
    int timestamp = currentWeather!.dt!;
    DateTime dateM =
    DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    String currentTime = DateFormat('a').format(dateM);
    int timestampSunSet = currentWeather!.sys!.sunset;
    DateTime date =
    DateTime.fromMillisecondsSinceEpoch(timestampSunrise * 1000);
    DateTime sunsetTime =
    DateTime.fromMillisecondsSinceEpoch(timestampSunSet * 1000);
    String formattedDate = DateFormat('hh:mm').format(date);
    String formattedDateSunSet = DateFormat('hh:mm').format(sunsetTime);
    mqData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back_ios)),
        title: Text("Daily Details"),
        centerTitle: true,
      ),
      backgroundColor: ColorConst.mColor[3],
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
        child: Container(
          height: mqData!.size.height*0.83,
          width: mqData!.size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              ColorConst.mColor[3],
              ColorConst.mColor[2],
              ColorConst.mColor[4],
            ],begin: AlignmentDirectional.topStart,end: AlignmentDirectional.bottomEnd)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 15,),
              Container(
                height: 30,
                width: 70,
                decoration: BoxDecoration(
                  color: ColorConst.mColor[0],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: FittedBox(child: currentTime == "AM" ?Text(dayMode,style: TextStyle(fontSize: 15),):Text("Night",style: TextStyle(fontSize: 15),))),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                      child: Image.network(iconUrl,fit: BoxFit.cover,)),
                  Text('${temp.toStringAsFixed(2)}°C',style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),),
                ],
              ),
              SizedBox(height: 10,),
              Text(currentWeather.weather[0].description,style: TextStyle(fontSize: 25),),
              SizedBox(height: 10,),
              /*-------Feels like--------*/
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/feels_like.png",height: 40,),
                    SizedBox(width: 10,),
                    Text("Feels like",style: TextStyle(color: Colors.grey.shade900),),
                    Expanded(child: SizedBox(width: 0,)),
                    Text('${(currentWeather.main.feelsLike- 273.15).toStringAsFixed(2)}°C',style: TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 10,
                width: mqData!.size.width,
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey,width: 2)),
                ),
              ),
              /*-------Wind--------*/
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/air.png",height: 40,),
                    SizedBox(width: 10,),
                    Text("Wind",style: TextStyle(color: Colors.grey.shade900),),
                    Expanded(child: SizedBox(width: 0,)),
                    Text('${currentWeather.wind.speed} mph SSW',style: TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 10,
                width: mqData!.size.width,
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey,width: 2)),
                ),
              ),
              /*-------Wind Gust--------*/
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/wind_gust.png",height: 40,),
                    SizedBox(width: 10,),
                    Text("Wind Gust",style: TextStyle(color: Colors.grey.shade900),),
                    Expanded(child: SizedBox(width: 0,)),
                    Text('${currentWeather.wind.gust} mph S',style: TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 10,
                width: mqData!.size.width,
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey,width: 2)),
                ),
              ),
              /*-------Humidity--------*/
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.water_drop_outlined,size: 30,color: Colors.grey.shade600,),
                    SizedBox(width: 10,),
                    Text("Humidity",style: TextStyle(color: Colors.grey.shade900),),
                    Expanded(child: SizedBox(width: 0,)),
                    Text('${currentWeather.main.humidity}%',style: TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 10,
                width: mqData!.size.width,
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey,width: 2)),
                ),
              ),
              /*-------SunRise--------*/
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.sunny_snowing,size: 30,color: Colors.grey.shade600,),
                    SizedBox(width: 10,),
                    Text("Sunrise",style: TextStyle(color: Colors.grey.shade900),),
                    Expanded(child: SizedBox(width: 0,)),
                    Text('${formattedDate} AM',style: TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 10,
                width: mqData!.size.width,
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey,width: 2)),
                ),
              ),
              /*-------SunSet--------*/
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.sunny,size: 30,color: Colors.grey.shade600,),
                    SizedBox(width: 10,),
                    Text("Sunset",style: TextStyle(color: Colors.grey.shade900),),
                    Expanded(child: SizedBox(width: 0,)),
                    Text('${formattedDateSunSet} PM',style: TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}