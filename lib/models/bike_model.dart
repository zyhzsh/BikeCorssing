import 'location_model.dart';

enum BikeStatus {
  leased,
  ide,
}

enum BikeType { Road, Cruiser, Touring, Mountain, Special }

class BikeModel {
  final String id;
  final String name;
  final List<BikeType> types;
  final BikeStatus status;
  final LocationModel lastRegisteredLocation;
  final int rentalPointsPerDay;
  final List<String> images;

  BikeModel({
    required this.id,
    required this.name,
    required this.types,
    required this.status,
    required this.lastRegisteredLocation,
    required this.rentalPointsPerDay,
    required this.images,
  });

//e.g: 100P/Day
  static List<BikeModel> sampleBikes = [
    BikeModel(
        id: 'sample-1',
        name: 'CycleSwoosh',
        types: [BikeType.Cruiser, BikeType.Road],
        status: BikeStatus.ide,
        lastRegisteredLocation: LocationModel(
            latitude: 0.0, longitude: 0.0, address: 'Sample Address'),
        rentalPointsPerDay: 100,
        images: [
          'https://source.unsplash.com/3tYZjGSBwbk/600x400',
          'https://source.unsplash.com/3tYZjGSBwbk/600x400'
        ]),
    BikeModel(
        id: 'sample-2',
        name: 'VelocityVelo',
        types: [BikeType.Cruiser, BikeType.Road],
        status: BikeStatus.ide,
        lastRegisteredLocation: LocationModel(
            latitude: 0.0, longitude: 0.0, address: 'Sample Address'),
        rentalPointsPerDay: 100,
        images: ['https://source.unsplash.com/3tYZjGSBwbk/600x400']),
    BikeModel(
        id: 'sample-3',
        name: 'AeroZoom',
        types: [BikeType.Touring, BikeType.Road],
        status: BikeStatus.ide,
        lastRegisteredLocation: LocationModel(
            latitude: 0.0, longitude: 0.0, address: 'Sample Address'),
        rentalPointsPerDay: 100,
        images: [
          'https://source.unsplash.com/3tYZjGSBwbk/600x400',
          'https://source.unsplash.com/3tYZjGSBwbk/600x400'
        ]),
  ];
}
