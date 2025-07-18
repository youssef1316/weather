import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/weather_data.dart';

class WeatherService {
  final String _apikey = '8da68ad01368437bbbd103051251607';

  Future <WeatherData> fetchWeather(double lat, double lon) async{
    final url = Uri.parse(
        'https://api.weatherapi.com/v1/forecast.json?key=$_apikey&q=$lat,$lon&days=7');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return WeatherData.fromJson(data);
    }
    else {
      throw Exception('Failed to fetch the weather data: ${response.statusCode}');
    }
  }
}