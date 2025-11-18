import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/weather_data.dart';

class WeatherInfoCard extends StatelessWidget {
  final WeatherData weather;

  const WeatherInfoCard({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            if (weather.isCached)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '(cached)',
                  style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                ),
              ),
            const SizedBox(height: 16),
            _buildInfoRow(Icons.thermostat, 'Temperature', 
                '${weather.temperature.toStringAsFixed(1)}°C'),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.air, 'Wind Speed', 
                '${weather.windSpeed.toStringAsFixed(1)} km/h'),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.cloud, 'Weather Code', 
                '${weather.weatherCode}'),
            const SizedBox(height: 16),
            Text(
              'Last Updated: ${DateFormat('MMM dd, yyyy HH:mm:ss').format(weather.lastUpdated)}',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue, size: 28),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }
}