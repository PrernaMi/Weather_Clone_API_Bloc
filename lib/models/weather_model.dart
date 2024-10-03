// class WeatherModel {
//   String? description;
//   String? icon;
//   String? id;
//   String? main;
//
//   WeatherModel({this.description, this.id, this.icon, this.main});
//
//   factory WeatherModel.fromJson(Map<String, dynamic> json) {
//     return WeatherModel(
//       id: json['id'],
//       icon: json['icon'],
//       description: json['description'],
//       main: json['main '],
//     );
//   }
// }
//
// class MainModel {
//   double? feels_like;
//   double? grnd_level;
//   double? humidity;
//   double? pressure;
//   double? sea_level;
//   double? temp;
//   double? temp_kf;
//   double? temp_max;
//   double? temp_min;
//
//   MainModel(
//       {this.feels_like,
//         this.grnd_level,
//         this.humidity,
//         this.pressure,
//         this.sea_level,
//         this.temp,
//         this.temp_kf,
//         this.temp_max,
//         this.temp_min});
//
//   factory MainModel.fromJson(Map<String, dynamic> json) {
//     return MainModel(
//       feels_like: json['feels_like'],
//       temp_min: json['temp_min'],
//       temp_max: json['temp_max'],
//       temp_kf: json['temp_kf'],
//       temp: json['temp'],
//       sea_level: json['sea_level'],
//       pressure: json['pressure'],
//       humidity: json['humidity'],
//       grnd_level: json['grnd_level'],
//     );
//   }
// }
//
// class CloudModel {
//   int? all;
//
//   CloudModel({this.all});
//
//   factory CloudModel.fromJson(Map<String, dynamic> json) {
//     return CloudModel(
//       all: json['all'],
//     );
//   }
// }
//
// class WindModel {
//   int? deg;
//   double? gust;
//   double? speed;
//
//   WindModel({this.deg, this.gust, this.speed});
//
//   factory WindModel.fromJson(Map<String, dynamic> json) {
//     return WindModel(
//       deg: json['deg'],
//       gust: json['gust'],
//       speed: json['speed'],
//     );
//   }
// }
//
// class RainModel {
//   double? threeh;
//
//   RainModel({this.threeh});
//
//   factory RainModel.fromJson(Map<String, dynamic> json) {
//     return RainModel(
//       threeh: json['3h'],
//     );
//   }
// }
//
// class SysModel {
//   String? pod;
//
//   SysModel({this.pod});
//
//   factory SysModel.fromJson(Map<String, dynamic> json) {
//     return SysModel(
//       pod: json['pod'],
//     );
//   }
// }
//
// class ListModel {
//   int? dt;
//   String? dt_txt;
//   double? pop;
//   int? visibility;
//   MainModel? main;
//   List<WeatherModel>? weather;
//   CloudModel? clouds;
//   WindModel? wind;
//   RainModel? rain;
//   SysModel? sys;
//
//   ListModel(
//       {this.main,
//         this.pop,
//         this.clouds,
//         this.dt,
//         this.dt_txt,
//         this.rain,
//         this.sys,
//         this.visibility,
//         this.weather,
//         this.wind});
//
//   factory ListModel.fromJson(Map<String, dynamic> json) {
//     List<WeatherModel> allWeather = [];
//     for (Map<String, dynamic> eachWea in json['weather']) {
//       allWeather.add(WeatherModel.fromJson(eachWea));
//     }
//     return ListModel(
//         dt: json['dt'],
//         visibility: json['visibility'],
//         pop: json['pop'],
//         dt_txt: json['dt_txt'],
//         main: MainModel.fromJson(json['main']),
//         clouds: CloudModel.fromJson(json['clouds']),
//         rain: RainModel.fromJson(json['rain']),
//         wind: WindModel.fromJson(json['wind']),
//         weather: allWeather);
//   }
// }
//
// class CoordModel {
//   double? lat;
//   double? lon;
//
//   CoordModel({this.lat, this.lon});
//
//   factory CoordModel.fromJson(Map<String, double> json) {
//     return CoordModel(
//       lat: json['lat'],
//       lon: json['lon'],
//     );
//   }
// }
//
// class CityModel {
//   String? country;
//   String? name;
//   int? id;
//   int? population;
//   int? sunrise;
//   int? sunset;
//   int? timezone;
//   CoordModel? coord;
//
//   CityModel(
//       {this.id,
//         this.name,
//         this.country,
//         this.population,
//         this.sunrise,
//         this.sunset,
//         this.timezone,
//         this.coord});
//
//   factory CityModel.fromJson(Map<String, dynamic> json) {
//     return CityModel(
//         id: json['id'],
//         country: json['country'],
//         name: json['name'],
//         population: json['population'],
//         sunrise: json['sunrise'],
//         sunset: json['sunset'],
//         timezone: json['timezone'],
//         coord: CoordModel.fromJson(json['coord']));
//   }
// }
//
// class WeatherDataModel {
//   List<ListModel>? list;
//   int? cnt;
//   String? cod;
//   CityModel? city;
//   int? message;
//
//   WeatherDataModel({this.city, this.list, this.cnt, this.cod, this.message});
//   factory WeatherDataModel.fromJson(Map<String,dynamic>json){
//     List<ListModel> allList =[];
//     for(Map<String,dynamic> eachMap in json['list']){
//       allList.add(ListModel.fromJson(eachMap));
//     }
//     return WeatherDataModel(
//         city: CityModel.fromJson(json['city']),
//         cnt: json['cnt'],
//         cod: json['cod'],
//         message: json['message'],
//         list: allList,
//     );
//   }
// }
