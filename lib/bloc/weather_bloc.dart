import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_api_clone/bloc/bloc_event.dart';
import 'package:weather_api_clone/bloc/bloc_state.dart';
import 'package:weather_api_clone/data/remote/api_helper.dart';

class WeatherBloc extends Bloc<BlocEvent, BlocState> {
  APIHelper? apiHelper;

  WeatherBloc({required this.apiHelper}) : super(InitialState()) {

    on<GetCurrentWeather>((event, emit) async {
      emit(LoadingState());
      if (event.city != null) {
        var currentWeatherData = await apiHelper!.getCurrentWeather(
            url:
            "https://api.openweathermap.org/data/2.5/weather?q=${event
                .city}&appid=5d31bddb440d5e3d481a66d202c500b8");
        var hourlyWeatherData = await apiHelper!.getHourlyWeather(
            url:
            "https://api.openweathermap.org/data/2.5/forecast?q=${event
                .city}&appid=5d31bddb440d5e3d481a66d202c500b8");
        if (currentWeatherData != null && hourlyWeatherData != null) {
          emit(LoadedState(
              currentWeather: currentWeatherData,
              hourlyWeather: hourlyWeatherData));
        } else {
          emit(ErrorState(errorMsg: "No data loaded"));
        }
      }
      else {
        var currentWeatherData = await apiHelper!.getCurrentWeather(
            url:
            "https://api.openweathermap.org/data/2.5/weather?lat=${event
                .lat}&lon=${event.lon}&appid=5d31bddb440d5e3d481a66d202c500b8");
        var hourlyWeatherData = await apiHelper!.getHourlyWeather(
            url:
            "https://api.openweathermap.org/data/2.5/forecast?lat=${event
                .lat}&lon=${event.lon}&appid=5d31bddb440d5e3d481a66d202c500b8");
        if (currentWeatherData != null && hourlyWeatherData != null) {
          emit(LoadedState(
              currentWeather: currentWeatherData,
              hourlyWeather: hourlyWeatherData));
        } else {
          emit(ErrorState(errorMsg: "No data loaded"));
        }
      }
    });
  }
}
