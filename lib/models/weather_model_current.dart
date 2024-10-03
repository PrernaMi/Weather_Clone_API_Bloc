class WeatherDataModel {
  CoordModel? coord;
  List<WeatherModel>? weather;
  String? base;
  MainModel? main;
  int? visibility;
  WindModel? wind;
  CloudModel? clouds;
  int? dt;
  SysModel? sys;
  int? timezone;
  int? id;
  String? name;
  int? cod;

  WeatherDataModel(
      {this.coord,
        this.weather,
        this.base,
        this.main,
        this.visibility,
        this.wind,
        this.clouds,
        this.dt,
        this.sys,
        this.timezone,
        this.id,
        this.name,
        this.cod});

  WeatherDataModel.fromJson(Map<String, dynamic> json) {
    coord = json['coord'] != null ? new CoordModel.fromJson(json['coord']) : null;
    if (json['weather'] != null) {
      weather = <WeatherModel>[];
      json['weather'].forEach((v) {
        weather!.add(new WeatherModel.fromJson(v));
      });
    }
    base = json['base'];
    main = json['main'] != null ? new MainModel.fromJson(json['main']) : null;
    visibility = json['visibility'];
    wind = json['wind'] != null ? new WindModel.fromJson(json['wind']) : null;
    clouds =
    json['clouds'] != null ? new CloudModel.fromJson(json['clouds']) : null;
    dt = json['dt'];
    sys = json['sys'] != null ? new SysModel.fromJson(json['sys']) : null;
    timezone = json['timezone'];
    id = json['id'];
    name = json['name'];
    cod = json['cod'];
  }

}

class CoordModel {
  double? lon;
  double? lat;

  CoordModel({this.lon, this.lat});

  CoordModel.fromJson(Map<String, dynamic> json) {
    lon = json['lon'];
    lat = json['lat'];
  }

}

class WeatherModel {
  int? id;
  String? main;
  String? description;
  String? icon;

  WeatherModel({this.id, this.main, this.description, this.icon});

  WeatherModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

}

class MainModel {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;
  int? seaLevel;
  int? grndLevel;

  MainModel(
      {this.temp,
        this.feelsLike,
        this.tempMin,
        this.tempMax,
        this.pressure,
        this.humidity,
        this.seaLevel,
        this.grndLevel});

  MainModel.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    feelsLike = json['feels_like'];
    tempMin = json['temp_min'];
    tempMax = json['temp_max'];
    pressure = json['pressure'];
    humidity = json['humidity'];
    seaLevel = json['sea_level'];
    grndLevel = json['grnd_level'];
  }

}

class WindModel {
  double? speed;
  int? deg;
  double? gust;

  WindModel({this.speed, this.deg, this.gust});

  WindModel.fromJson(Map<String, dynamic> json) {
    speed = json['speed'];
    deg = json['deg'];
    gust = json['gust'];
  }

}

class CloudModel {
  int? all;

  CloudModel({this.all});

  CloudModel.fromJson(Map<String, dynamic> json) {
    all = json['all'];
  }

}

class SysModel {
  int? type;
  int? id;
  String? country;
  int? sunrise;
  int? sunset;

  SysModel({this.type, this.id, this.country, this.sunrise, this.sunset});

  SysModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    country = json['country'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }

}
