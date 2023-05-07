import 'dart:math';
import '../models/location_model.dart';

extension LocationDistanceExtension on LocationModel {

  String calculateDistance(double targetLat, double targetLng) {
    const double earthRadius = 6371.0;
    final currentLat = latitude;
    final currentLng = longitude;
    double latDiff = _toRadians(targetLat - currentLat);
    double lngDiff = _toRadians(targetLng - currentLng);
    double a = sin(latDiff / 2) * sin(latDiff / 2) +
        cos(_toRadians(currentLat)) * cos(_toRadians(targetLat)) * sin(lngDiff / 2) * sin(lngDiff / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;
    return distance.toStringAsFixed(2);
  }
  double _toRadians(double degrees) {
    return degrees * pi / 180.0;
  }

}
