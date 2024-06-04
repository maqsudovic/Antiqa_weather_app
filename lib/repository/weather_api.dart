import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task1/models/wheather.dart';

class WeatherRepository {
  static const apiKey = '74de423d3f2b7f0e1c5912859770cc59';
  static const baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<WeatherData> getWeatherData(String city) async {
    final url = Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return WeatherData.fromJson(json);
    } else {
      throw Exception('🔴Xatolika yuz berdi🔴');
    }
  }
}
