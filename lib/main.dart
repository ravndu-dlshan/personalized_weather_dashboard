import 'package:flutter/material.dart';
import 'models/coordinates.dart';
import 'models/weather_data.dart';
import 'services/weather_service.dart';
import 'services/cache_service.dart';
import 'widgets/coordinates_card.dart';
import 'widgets/weather_info_card.dart';
import 'widgets/url_display.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const WeatherHomePage(),
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({Key? key}) : super(key: key);

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final TextEditingController _indexController = TextEditingController(text: '194174');
  Coordinates? _coordinates;
  WeatherData? _weatherData;
  String? _requestUrl;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _calculateCoordinates();
    _loadCachedWeather();
  }

  void _calculateCoordinates() {
    try {
      setState(() {
        _coordinates = Coordinates.fromIndex(_indexController.text);
        _requestUrl = WeatherService.buildUrl(_coordinates!);
        _error = null;
      });
    } catch (e) {
      setState(() {
        _error = 'Invalid index format';
        _coordinates = null;
        _requestUrl = null;
      });
    }
  }

  Future<void> _loadCachedWeather() async {
    final cached = await CacheService.loadWeather();
    if (cached != null) {
      setState(() {
        _weatherData = cached;
      });
    }
  }

  Future<void> _fetchWeather() async {
    if (_coordinates == null) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final weather = await WeatherService.fetchWeather(_coordinates!);
      await CacheService.saveWeather(weather);
      
      setState(() {
        _weatherData = weather;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = 'Failed to fetch weather. ${_weatherData != null ? "Showing cached data." : ""}';
      });

      if (_weatherData == null) {
        await _loadCachedWeather();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Forecast'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _indexController,
                decoration: InputDecoration(
                  labelText: 'Student Index',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.person),
                ),
                onChanged: (_) => _calculateCoordinates(),
              ),
              const SizedBox(height: 16),
              
              if (_coordinates != null)
                CoordinatesCard(
                  index: _indexController.text,
                  coordinates: _coordinates,
                ),
              
              const SizedBox(height: 16),
              
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _fetchWeather,
                icon: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.cloud_download),
                label: Text(_isLoading ? 'Fetching...' : 'Fetch Weather'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              
              if (_error != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red.shade700),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _error!,
                          style: TextStyle(color: Colors.red.shade700),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              
              if (_weatherData != null) ...[
                const SizedBox(height: 16),
                WeatherInfoCard(weather: _weatherData!),
              ],
              
              if (_requestUrl != null) ...[
                const SizedBox(height: 16),
                const Text(
                  'Request URL:',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                UrlDisplay(url: _requestUrl!),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _indexController.dispose();
    super.dispose();
  }
}