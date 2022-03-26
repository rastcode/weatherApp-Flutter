import 'package:flutter/foundation.dart';

class Weather {
  String? temp;
  String? wind;
  String? sesc;


  Weather({required this.temp,required this.wind,required this.sesc});

  factory Weather.fromJson(Map<String,dynamic>json){
    return Weather(
        temp: json['temperature'],
        wind: json['wind'],
        sesc: json['description'],
    );
  }
}

class Forecast{
  String? day;
  String? temp;
  String? wind;
  Forecast({required this.day,required this.temp,required this.wind});

  factory Forecast.fromJson(Map<String,dynamic>json){
    return Forecast(
      day: json['day'],
      temp: json['temperature'],
      wind: json['wind']
    );
  }

}