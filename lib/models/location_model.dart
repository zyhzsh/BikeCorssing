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
    latitude: 37.422,
    longitude: -122.084,
    address: '1600 Amphitheatre Parkway, Mountain View, CA',
  );
}
