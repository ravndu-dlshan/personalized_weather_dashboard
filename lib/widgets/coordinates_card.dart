import 'package:flutter/material.dart';
import '../models/coordinates.dart';

class CoordinatesCard extends StatelessWidget {
  final String index;
  final Coordinates? coordinates;

  const CoordinatesCard({
    Key? key,
    required this.index,
    this.coordinates,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Student Index: $index',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            if (coordinates != null) ...[
              const SizedBox(height: 8),
              Text(
                'Latitude: ${coordinates!.formattedLat}°',
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 4),
              Text(
                'Longitude: ${coordinates!.formattedLon}°',
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ],
          ],
        ),
      ),
    );
  }
}