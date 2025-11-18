class Coordinates {
  final double latitude;
  final double longitude;

  Coordinates({required this.latitude, required this.longitude});

  static Coordinates fromIndex(String index) {
    if (index.length < 4) {
      throw ArgumentError('Index must be at least 4 characters');
    }

    final firstTwo = int.parse(index.substring(0, 2));
    final nextTwo = int.parse(index.substring(2, 4));

    final lat = 5 + (firstTwo / 10.0);
    final lon = 79 + (nextTwo / 10.0);

    return Coordinates(latitude: lat, longitude: lon);
  }

  String get formattedLat => latitude.toStringAsFixed(2);
  String get formattedLon => longitude.toStringAsFixed(2);
}