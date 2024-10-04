class WeatherDataModel {
  CoordModel? coord;
  List<WeatherModel>? weather;
  dynamic? base;
  MainModel? main;
  dynamic? visibility;
  WindModel? wind;
  CloudModel? clouds;
  dynamic? dt;
  SysModel? sys;
  dynamic? timezone;
  dynamic? id;
  dynamic? name;
  dynamic? cod;

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
  dynamic? lon;
  dynamic? lat;

  CoordModel({this.lon, this.lat});

  CoordModel.fromJson(Map<String, dynamic> json) {
    lon = json['lon'];
    lat = json['lat'];
  }

}

class WeatherModel {
  dynamic? id;
  dynamic? main;
  dynamic? description;
  dynamic? icon;

  WeatherModel({this.id, this.main, this.description, this.icon});

  WeatherModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

}

class MainModel {
  dynamic? temp;
  dynamic? feelsLike;
  dynamic? tempMin;
  dynamic? tempMax;
  dynamic? pressure;
  dynamic? humidity;
  dynamic? seaLevel;
  dynamic? grndLevel;

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
  dynamic? speed;
  dynamic? deg;
  dynamic? gust;

  WindModel({this.speed, this.deg, this.gust});

  WindModel.fromJson(Map<String, dynamic> json) {
    speed = json['speed'];
    deg = json['deg'];
    gust = json['gust'];
  }

}

class CloudModel {
  dynamic? all;

  CloudModel({this.all});

  CloudModel.fromJson(Map<String, dynamic> json) {
    all = json['all'];
  }

}

class SysModel {
  dynamic? type;
  dynamic? id;
  dynamic? country;
  dynamic? sunrise;
  dynamic? sunset;

  SysModel({this.type, this.id, this.country, this.sunrise, this.sunset});

  SysModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    country = json['country'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }

}
