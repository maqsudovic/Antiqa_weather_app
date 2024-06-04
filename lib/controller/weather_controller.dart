import 'package:task1/models/wheather.dart';
import 'package:task1/repository/weather_api.dart';

class WeatherController {
  final WeatherRepository _weatherRepository;

  WeatherController(this._weatherRepository);

  Future<WeatherData> getWeatherForCity(String city) async {
    return await _weatherRepository.getWeatherData(city);
  }
}