import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:weather_api_clone/models/weather_model.dart';
import 'package:weather_api_clone/models/weather_model_current.dart';
class APIHelper{

  Future<WeatherDataModel?> getWeather({required String url})async{
    Uri uri = Uri.parse(url);
    var response = await http.get(uri);
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      //convert data to model when model created.
      var dataModel = WeatherDataModel.fromJson(data);
      return dataModel;
    }else{
      return null;
    }
  }
}