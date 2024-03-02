
class WeatherModel {
  late String name;
  late String country;
  late String weather;
  late String icon;
  late String temp;
  late String wind;
  late String feels_like;
  late String pressure;
  late String humidity;

  WeatherModel({
    required this.name, required this.wind,
    required this.country, required this.temp,
    required this.weather, required this.icon,
    required this.humidity, required this.pressure,
    required this.feels_like
  });

  //De-serialization: (GET API)
  //I manually create a fromJson function without using json automatic serializable/deserializable
  //because in this case my weather mapped data is in nested key/values pairs:
  WeatherModel.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    country = map['sys']['country'];
    weather = map['weather'][0]['main'];
    icon = map['weather'][0]['icon'];
    temp = map['main']['temp'].toString();
    feels_like = map['main']['feels_like'].toString();
    pressure = map['main']['pressure'].toString();
    humidity = map['main']['humidity'].toString();
    wind = map['wind']['speed'].toString();
  }

}