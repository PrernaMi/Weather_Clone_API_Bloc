class HourlyWeatherModel {
  dynamic? cod;
  dynamic? message;
  dynamic? cnt;
  List<ListModel>? list;
  City? city;

  HourlyWeatherModel({this.cod, this.message, this.cnt, this.list, this.city});

  HourlyWeatherModel.fromJson(Map<String, dynamic> json) {
    cod = json['cod'];
    message = json['message'];
    cnt = json['cnt'];
    if (json['list'] != null) {
      list = <ListModel>[];
      json['list'].forEach((v) {
        list!.add(new ListModel.fromJson(v));
      });
    }
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
  }

}

class ListModel {
  dynamic? dt;
  Main? main;
  List<Weather>? weather;
  Clouds? clouds;
  Wind? wind;
  dynamic? visibility;
  dynamic? pop;
  Sys? sys;
  dynamic? dtTxt;
  Rain? rain;

  ListModel(
      {this.dt,
        this.main,
        this.weather,
        this.clouds,
        this.wind,
        this.visibility,
        this.pop,
        this.sys,
        this.dtTxt,
        this.rain});

  ListModel.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    main = json['main'] != null ? new Main.fromJson(json['main']) : null;
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(new Weather.fromJson(v));
      });
    }
    clouds =
    json['clouds'] != null ? new Clouds.fromJson(json['clouds']) : null;
    wind = json['wind'] != null ? new Wind.fromJson(json['wind']) : null;
    visibility = json['visibility'];
    pop = json['pop'];
    sys = json['sys'] != null ? new Sys.fromJson(json['sys']) : null;
    dtTxt = json['dt_txt'];
    rain = json['rain'] != null ? new Rain.fromJson(json['rain']) : null;
  }

}

class Main {
  dynamic? temp;
  dynamic? feelsLike;
  dynamic? tempMin;
  dynamic? tempMax;
  dynamic? pressure;
  dynamic? seaLevel;
  dynamic? grndLevel;
  dynamic? humidity;
  dynamic? tempKf;

  Main(
      {this.temp,
        this.feelsLike,
        this.tempMin,
        this.tempMax,
        this.pressure,
        this.seaLevel,
        this.grndLevel,
        this.humidity,
        this.tempKf});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    feelsLike = json['feels_like'];
    tempMin = json['temp_min'];
    tempMax = json['temp_max'];
    pressure = json['pressure'];
    seaLevel = json['sea_level'];
    grndLevel = json['grnd_level'];
    humidity = json['humidity'];
    tempKf = json['temp_kf'];
  }

}

class Weather {
  dynamic? id;
  dynamic? main;
  dynamic? description;
  dynamic? icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }
}

class Clouds {
  dynamic? all;

  Clouds({this.all});

  Clouds.fromJson(Map<String, dynamic> json) {
    all = json['all'];
  }
}

class Wind {
  dynamic? speed;
  dynamic? deg;
  dynamic? gust;

  Wind({this.speed, this.deg, this.gust});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'];
    deg = json['deg'];
    gust = json['gust'];
  }

}

class Sys {
  dynamic? pod;

  Sys({this.pod});

  Sys.fromJson(Map<String, dynamic> json) {
    pod = json['pod'];
  }
}

class Rain {
  dynamic? d3h;

  Rain({this.d3h});

  Rain.fromJson(Map<String, dynamic> json) {
    d3h = json['3h'];
  }

}

class City {
  dynamic? id;
  dynamic? name;
  Coord? coord;
  dynamic? country;
  dynamic? population;
  dynamic? timezone;
  dynamic? sunrise;
  dynamic? sunset;

  City(
      {this.id,
        this.name,
        this.coord,
        this.country,
        this.population,
        this.timezone,
        this.sunrise,
        this.sunset});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    coord = json['coord'] != null ? new Coord.fromJson(json['coord']) : null;
    country = json['country'];
    population = json['population'];
    timezone = json['timezone'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }

}

class Coord {
  dynamic? lat;
  dynamic? lon;

  Coord({this.lat, this.lon});

  Coord.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
  }

}
