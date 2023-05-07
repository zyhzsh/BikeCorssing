import 'location_model.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

enum BikeStatus {
  leased,
  ide,
}

enum BikeType { road, cruiser, touring, mountain, special }

class BikeModel {
  final String id;
  final String name;
  final List<BikeType> types;
  final BikeStatus status;
  final LocationModel lastRegisteredLocation;
  final int rentalPointsPerDay;
  final List<String> images;
  final DateTime? createdAt;

  BikeModel(
      {required this.id,
      required this.name,
      required this.types,
      required this.status,
      required this.lastRegisteredLocation,
      required this.rentalPointsPerDay,
      required this.images,
      DateTime? createAt})
      : createdAt = DateTime.now();

  String get formattedDate {
    return formatter.format(createdAt!);
  }

//e.g: 100P/Day
  static List<BikeModel> sampleBikes = [
    BikeModel(
      id: 'sample-1',
      name: 'CycleSwoosh',
      types: [BikeType.cruiser, BikeType.road],
      status: BikeStatus.ide,
      lastRegisteredLocation: LocationModel(
          latitude: 51.454583, longitude: 5.438979, address: 'Sample Address'),
      rentalPointsPerDay: 100,
      images: [
        'https://images.unsplash.com/photo-1507035895480-2b3156c31fc8',
      ],
      createAt: DateTime(2021, 8, 1),
    ),
    BikeModel(
        id: 'sample-2',
        name: 'VelocityVelo',
        types: [BikeType.cruiser, BikeType.road],
        status: BikeStatus.ide,
        lastRegisteredLocation: LocationModel(
            latitude: 51.423653, longitude: 5.448694, address: 'Sample Address'),
        rentalPointsPerDay: 100,
        images: [
          'https://images.unsplash.com/photo-1507035895480-2b3156c31fc8',
        ]),
    BikeModel(
        id: 'sample-3',
        name: 'AeroZoom',
        types: [BikeType.touring, BikeType.road],
        status: BikeStatus.ide,
        lastRegisteredLocation: LocationModel(
            latitude: 51.458495, longitude: 5.466570, address: 'Sample Address'),
        rentalPointsPerDay: 100,
        images: [
          'https://images.unsplash.com/photo-1507035895480-2b3156c31fc8',
          'https://source.unsplash.com/3tYZjGSBwbk/300x400'
        ]),
    BikeModel(
        id: 'sample-4',
        name: 'XXXXX-4',
        types: [BikeType.touring, BikeType.road],
        status: BikeStatus.ide,
        lastRegisteredLocation: LocationModel(
            latitude: 51.437643, longitude: 5.407942, address: 'Sample Address'),
        rentalPointsPerDay: 100,
        images: [
          'https://images.unsplash.com/photo-1507035895480-2b3156c31fc8',
          'https://source.unsplash.com/3tYZjGSBwbk/300x400'
        ]),
    BikeModel(
        id: 'sample-5',
        name: 'T-5',
        types: [BikeType.touring, BikeType.road],
        status: BikeStatus.ide,
        lastRegisteredLocation: LocationModel(
            latitude: 51.562, longitude: 5.04952, address: 'Sample Address'),
        rentalPointsPerDay: 100,
        images: [
          'https://images.unsplash.com/photo-1507035895480-2b3156c31fc8',
          'https://source.unsplash.com/3tYZjGSBwbk/300x400'
        ]),
  ];
}
