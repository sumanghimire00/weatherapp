// To parse  this JSON data, do
//
//     final hourlyWeatherModel = hourlyWeatherModelFromJson(jsonString);

import 'dart:convert';

HourlyWeatherModel hourlyWeatherModelFromJson(String str) =>
    HourlyWeatherModel.fromJson(json.decode(str));

class HourlyWeatherModel {
  int message;
  List<ListElement> list;

  HourlyWeatherModel({
    required this.message,
    required this.list,
  });

  factory HourlyWeatherModel.fromJson(Map<String, dynamic> json) =>
      HourlyWeatherModel(
        message: json["message"],
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
      );
}

class Coord {
  double lat;
  double lon;

  Coord({
    required this.lat,
    required this.lon,
  });

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
      };
}

class ListElement {
  int dt;
  MainClass main;
  List<Weather> weather;
  Wind wind;
  DateTime dtTxt;

  ListElement({
    required this.dt,
    required this.main,
    required this.weather,
    required this.wind,
    required this.dtTxt,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        dt: json["dt"],
        main: MainClass.fromJson(json["main"]),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        wind: Wind.fromJson(json["wind"]),
        dtTxt: DateTime.parse(json["dt_txt"]),
      );
}

class Clouds {
  int all;

  Clouds({
    required this.all,
  });

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json["all"],
      );
}

class MainClass {
  int temp;
  double feelsLike;
  int tempMin;
  int tempMax;
  int pressure;
  int seaLevel;
  int grndLevel;
  int humidity;
  double tempKf;

  MainClass({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
  });

  factory MainClass.fromJson(Map<String, dynamic> json) => MainClass(
        temp: json["temp"].toInt(),
        feelsLike: json["feels_like"].toDouble(),
        tempMin: json["temp_min"].toInt(),
        tempMax: json["temp_max"].toInt(),
        pressure: json["pressure"],
        seaLevel: json["sea_level"],
        grndLevel: json["grnd_level"],
        humidity: json["humidity"],
        tempKf: json["temp_kf"].toDouble(),
      );
}

class Weather {
  int id;
  String? icon;

  Weather({
    required this.id,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        icon: json["icon"],
      );
}

class Wind {
  double speed;
  int deg;
  double gust;

  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"].toDouble(),
        deg: json["deg"],
        gust: json["gust"].toDouble(),
      );
}
