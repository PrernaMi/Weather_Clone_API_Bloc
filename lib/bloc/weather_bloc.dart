import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_api_clone/bloc/weather_events.dart';
import 'package:weather_api_clone/bloc/weather_state.dart';
import 'package:weather_api_clone/data/remote/api_helper.dart';

class WeatherBloc extends Bloc<BlocEvent, BlocState> {
  APIHelper? apiHelper;

  WeatherBloc({required this.apiHelper}) : super(BlocInitialState()) {
    on<GetWeatherEvent>((event, emit) async {
      emit(BlocLoadingState());
      var data = await apiHelper!.getWeather(
          url:
              "https://api.openweathermap.org/data/2.5/weather?lat=${event.lat}&lon=${event.lon}&appid=5d31bddb440d5e3d481a66d202c500b8");
      if (data != null) {
        emit(BlocLoadedState(weather: data));
      } else {
        emit(BlocErrorState(errorMsg: "No Data Loaded"));
      }
    });
  }
}
