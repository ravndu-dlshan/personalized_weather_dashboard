import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_data.dart';
import '../models/coordinates.dart';

class WeatherService {
  static String buildUrl(Coordinates coords) {
    return 'https://api.open-meteo.com/v1/forecast?'
        'latitude=${coords.latitude}&'
        'longitude=${coords.longitude}&'
        'current_weather=true';
  }

  static Future<WeatherData> fetchWeather(Coordinates coords) async {
    final url = buildUrl(coords);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final current = data['current_weather'];

      return WeatherData(
        temperature: current['temperature'].toDouble(),
        windSpeed: current['windspeed'].toDouble(),
        weatherCode: current['weathercode'],
        lastUpdated: DateTime.now(),
      );
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}