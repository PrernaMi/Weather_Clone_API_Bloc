import 'package:weather_api_clone/models/weather_model.dart';
import 'package:weather_api_clone/models/weather_model_current.dart';

abstract class BlocState{}
class InitialState extends BlocState{}
class LoadingState extends BlocState{}
class LoadedState extends BlocState{
  WeatherDataModel? currentWeather;
  HourlyWeatherModel? hourlyWeather;
  LoadedState({required this.currentWeather,required this.hourlyWeather});
}
class ErrorState extends BlocState{
  String? errorMsg;
  ErrorState({required this.errorMsg});
}