abstract class BlocEvent{}

class GetWeatherEvent extends BlocEvent{
  double? lat;
  double? lon;
  GetWeatherEvent({required this.lat,required this.lon});
}