abstract class BlocEvent{}

class GetCurrentWeather extends BlocEvent{
  String?city;
  double?lat;
  double?lon;

  GetCurrentWeather({this.city,this.lat,this.lon});
}
class GetHourlyWeather extends BlocEvent{
  String?city;
  double?lat;
  double?lon;

  GetHourlyWeather({this.city,this.lat,this.lon});
}