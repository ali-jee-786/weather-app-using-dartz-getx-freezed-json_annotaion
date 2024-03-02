import 'dart:convert';
import 'package:best_weather_app/app/config/errors.dart';
import 'package:best_weather_app/model/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

class WeatherApi {

  Future <Either<WeatherModel, FetchError>> getWeatherData(String query) async {
    var url = 'https://api.openweathermap.org/data/2.5/weather?q=$query&appid=4ff7103dc2b17dceac536d8b049bb596&units=metric';
    try{
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        WeatherModel weatherModel = WeatherModel.fromMap(data);
        return Left(weatherModel);
      }
      else{
        print(response.statusCode);
        return const Right(FetchError.NetworkError());
      }
    }
    catch(e){
      return const Right(FetchError.NetworkError());
    }
  }

}