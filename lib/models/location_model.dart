class LocationModel {
  final double latitude;
  final double longitude;
  final String address;

  LocationModel({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  static LocationModel sampleLocation = LocationModel(
    latitude: 51.446663,
    longitude:5.476954,
    address: '....',
  );
}
