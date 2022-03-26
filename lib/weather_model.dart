class Weather {
  String? cityName;
  double? temp;
  double? wind;
  int? humidity;
  double? feels_like;
  int? pressure;
  String?main;

  Weather({
    this.cityName,
    this.temp,
    this.humidity,
    this.feels_like,
    this.pressure,
    this.main,
  });

  //functiion
  Weather.fromJson(Map<String, dynamic> json) {
    cityName = json["name"];
    temp = json["main"]["temp"];
    wind = json["wind"]["speed"];
    pressure = json["main"]["pressure"];
    humidity = json["main"]["humidity"];
    feels_like = json["main"]["feels_like"];
    main=json['weather'][0]['main'];
  }
}
