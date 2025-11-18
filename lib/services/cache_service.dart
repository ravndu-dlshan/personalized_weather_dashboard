import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/weather_data.dart';

class CacheService {
  static const String _weatherKey = 'cached_weather';

  static Future<void> saveWeather(WeatherData weather) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = json.encode(weather.toJson());
    await prefs.setString(_weatherKey, jsonData);
  }

  static Future<WeatherData?> loadWeather() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(_weatherKey);
    
    if (jsonData != null) {
      final data = json.decode(jsonData);
      return WeatherData.fromJson(data);
    }
    return null;
  }
}