import 'package:weather_api_clone/models/weather_model.dart';
import 'package:weather_api_clone/models/weather_model_current.dart';

abstract class BlocState{}
class BlocInitialState extends BlocState{}
class BlocLoadedState extends BlocState{
  WeatherDataModel? weather;
  BlocLoadedState({required this.weather});
}
class BlocLoadingState extends BlocState{}
class BlocErrorState extends BlocState{
  String? errorMsg;
  BlocErrorState({required this.errorMsg});
}