import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class WeatherService {
  final String apiKey = '2062dc8e6d70aa1e13ae0c2dfe402ad8';
  final String baseurl = 'http://api.openweathermap.org/data/2.5/weather';
  Future<Map<String, dynamic>> getWeather(String cityName) async {
    final response = await http
        .get(Uri.parse('$baseurl?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Map<String, dynamic>> fetchWeather() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    double lat = position.latitude, lon = position.longitude;
    final response = await http.get(
        Uri.parse('$baseurl?lat=$lat&lon=$lon&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Map<String, dynamic>> fetchWeatherByLocation(
      double lat, double lon) async {
    final response = await http.get(
        Uri.parse('$baseurl?lat=$lat&lon=$lon&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
