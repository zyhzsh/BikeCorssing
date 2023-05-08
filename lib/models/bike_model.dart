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
      types: [BikeType.road],
      status: BikeStatus.ide,
      lastRegisteredLocation: LocationModel(latitude: 51.441518, longitude: 5.469729, address: 'Eindhoven Central Station'),
      rentalPointsPerDay: 100,
      images: [
        'https://images.unsplash.com/photo-1507035895480-2b3156c31fc8',
      ],
      createAt: DateTime(2021, 8, 1),
    ),
    BikeModel(
        id: 'sample-2',
        name: 'VelocityVelo',
        types: [BikeType.road],
        status: BikeStatus.ide,
        lastRegisteredLocation: LocationModel(latitude: 51.443524, longitude: 5.478767, address: 'Philips Stadium, Eindhoven'),
        rentalPointsPerDay: 100,
        images: [
          'https://images.unsplash.com/photo-1485965120184-e220f721d03e',
        ]),
    BikeModel(
        id: 'sample-3',
        name: 'AeroZoom',
        types: [BikeType.road],
        status: BikeStatus.ide,
        lastRegisteredLocation: LocationModel(latitude: 51.560171, longitude: 5.061488, address: 'Safaripark Beekse Bergen, Tilburg'),
        rentalPointsPerDay: 100,
        images: [
          'https://images.unsplash.com/photo-1487803836022-91054ca05fdd',
        ]),
    BikeModel(
        id: 'sample-4',
        name: 'RideFlyer',
        types: [BikeType.road],
        status: BikeStatus.ide,
        lastRegisteredLocation: LocationModel(latitude: 51.561416, longitude: 5.086547, address: 'Efteling Theme Park, Kaatsheuvel'),
        rentalPointsPerDay: 100,
        images: [
          'https://images.unsplash.com/photo-1626118703370-f60e1982b320',
        ]),
    BikeModel(
        id: 'sample-5',
        name: 'VelocityVelo',
        types: [BikeType.road],
        status: BikeStatus.ide,
        lastRegisteredLocation: LocationModel(latitude: 51.558174, longitude: 5.077945, address: 'Tilburg University, Tilburg'),
        rentalPointsPerDay: 100,
        images: [
          'https://images.unsplash.com/photo-1583220113679-91e9833f1ff7',
        ]),
    BikeModel(
        id: 'sample-6',
        name: 'WheelWing',
        types: [BikeType.road, BikeType.special],
        status: BikeStatus.ide,
        lastRegisteredLocation: LocationModel(latitude: 52.370216, longitude: 4.895168, address: 'Dam Square, Amsterdam'),
        rentalPointsPerDay: 100,
        images: [
          'https://images.unsplash.com/photo-1624737676957-66a02dc17ff2',
        ]),
    BikeModel(
        id: 'sample-7',
        name: 'Unique Urbanite',
        types: [BikeType.cruiser, BikeType.special],
        status: BikeStatus.ide,
        lastRegisteredLocation: LocationModel(latitude: 51.9225, longitude: 4.47917, address: 'Rotterdam Central Station, Rotterdam'),
        rentalPointsPerDay: 100,
        images: [
          'https://plus.unsplash.com/premium_photo-1679528244908-8d2e6901d418',
        ]),
    BikeModel(
        id: 'sample-8',
        name: 'BeachBomber',
        types: [BikeType.cruiser],
        status: BikeStatus.ide,
        lastRegisteredLocation: LocationModel(latitude: 52.090737, longitude: 5.12142, address: 'Dom Tower, Utrecht'),
        rentalPointsPerDay: 100,
        images: [
          'https://images.unsplash.com/photo-1524453975318-d81a700fa170',
        ]),
    BikeModel(
        id: 'sample-9',
        name: 'BeachBomber',
        types: [BikeType.cruiser],
        status: BikeStatus.ide,
        lastRegisteredLocation: LocationModel(latitude: 51.812562, longitude: 4.69093, address: 'Euromast, Rotterdam'),
        rentalPointsPerDay: 100,
        images: [
          'https://images.unsplash.com/photo-1528784351875-d797d86873a1'
        ]),
    BikeModel(
        id: 'sample-10',
        name: 'PedalPacer',
        types: [BikeType.cruiser],
        status: BikeStatus.ide,
        lastRegisteredLocation: LocationModel(latitude: 52.37403, longitude: 4.88969, address: 'Anne Frank House, Amsterdam'),
        rentalPointsPerDay: 100,
        images: [
          'https://images.unsplash.com/photo-1534522646955-e64333b57c9b'
        ]),
    BikeModel(
        id: 'sample-11',
        name: 'PedalPacer',
        types: [BikeType.cruiser],
        status: BikeStatus.ide,
        lastRegisteredLocation: LocationModel(
            latitude: 51.433731,
            longitude: 5.477835,
            address: 'Philips Stadium, Eindhoven'),
        rentalPointsPerDay: 100,
        images: [
          'https://images.unsplash.com/photo-1534522646955-e64333b57c9b'
        ]),
    BikeModel(
        id: 'sample-12',
        name: 'SunsetScooter',
        types: [BikeType.cruiser],
        status: BikeStatus.ide,
        lastRegisteredLocation: LocationModel(
            latitude: 51.433731,
            longitude: 5.477835,
            address: 'Philips Stadium, Eindhoven'),
        rentalPointsPerDay: 100,
        images: [
          'https://images.unsplash.com/photo-1523797700695-731dafb63495'
        ]),
    BikeModel(
        id: 'sample-13',
        name: 'CoastalCruiser',
        types: [BikeType.cruiser],
        status: BikeStatus.ide,
        lastRegisteredLocation: LocationModel(
            latitude: 51.433731,
            longitude: 5.477835,
            address: 'Philips Stadium, Eindhoven'),
        rentalPointsPerDay: 100,
        images: [
          'https://images.unsplash.com/photo-1541459740308-f6349b68ba85'
        ]),
    BikeModel(
        id: 'sample-14',
        name: 'Wanderer',
        types: [BikeType.touring],
        status: BikeStatus.ide,
        lastRegisteredLocation: LocationModel(
            latitude: 51.433731,
            longitude: 5.477835,
            address: 'Philips Stadium, Eindhoven'),
        rentalPointsPerDay: 100,
        images: ['https://images.unsplash.com/photo-1558342697-9657a85f357b']),
    BikeModel(
        id: 'sample-16',
        name: 'Roamer',
        types: [BikeType.touring],
        status: BikeStatus.ide,
        lastRegisteredLocation: LocationModel(
            latitude: 51.433731,
            longitude: 5.477835,
            address: 'Philips Stadium, Eindhoven'),
        rentalPointsPerDay: 100,
        images: ['https://images.unsplash.com/photo-1535674691863-e7511582b10c']),
    BikeModel(
        id: 'sample-17',
        name: 'Adventurer',
        types: [BikeType.touring, BikeType.cruiser],
        status: BikeStatus.ide,
        lastRegisteredLocation: LocationModel(
            latitude: 51.433731,
            longitude: 5.477835,
            address: 'Philips Stadium, Eindhoven'),
        rentalPointsPerDay: 100,
        images: ['https://images.unsplash.com/photo-1606921838199-5964366769bd']),
    BikeModel(
        id: 'sample-18',
        name: 'Voyager',
        types: [BikeType.touring, BikeType.cruiser],
        status: BikeStatus.ide,
        lastRegisteredLocation: LocationModel(
            latitude: 51.433731,
            longitude: 5.477835,
            address: 'Philips Stadium, Eindhoven'),
        rentalPointsPerDay: 100,
        images: ['https://images.unsplash.com/photo-1606921860430-17e31590b084']),

    BikeModel(
        id: 'sample-19',
        name: 'Trailblazer',
        types: [BikeType.mountain],
        status: BikeStatus.ide,
        lastRegisteredLocation: LocationModel(
            latitude: 51.433731,
            longitude: 5.477835,
            address: 'Philips Stadium, Eindhoven'),
        rentalPointsPerDay: 100,
        images: ['https://images.unsplash.com/photo-1575585269294-7d28dd912db8']),
    BikeModel(
        id: 'sample-20',
        name: 'Summit Rider',
        types: [BikeType.mountain],
        status: BikeStatus.ide,
        lastRegisteredLocation: LocationModel(
            latitude: 51.433731,
            longitude: 5.477835,
            address: 'Philips Stadium, Eindhoven'),
        rentalPointsPerDay: 100,
        images: ['https://images.unsplash.com/photo-1596738141905-51e94b519d69']),
    BikeModel(
        id: 'sample-21',
        name: 'Dirt Devil',
        types: [BikeType.mountain],
        status: BikeStatus.ide,
        lastRegisteredLocation: LocationModel(
            latitude: 51.433731,
            longitude: 5.477835,
            address: 'Philips Stadium, Eindhoven'),
        rentalPointsPerDay: 100,
        images: ['https://images.unsplash.com/photo-1575734124434-aeabcbd508b3']),
    BikeModel(
        id: 'sample-22',
        name: 'Mountain Maverick',
        types: [BikeType.mountain],
        status: BikeStatus.ide,
        lastRegisteredLocation: LocationModel(
            latitude: 51.433731,
            longitude: 5.477835,
            address: 'Philips Stadium, Eindhoven'),
        rentalPointsPerDay: 100,
        images: ['https://images.unsplash.com/photo-1608531428470-4471739c4359']),
    BikeModel(
        id: 'sample-23',
        name: 'Serenity',
        types: [BikeType.special],
        status: BikeStatus.ide,
        lastRegisteredLocation: LocationModel(
            latitude: 51.433731,
            longitude: 5.477835,
            address: 'Philips Stadium, Eindhoven'),
        rentalPointsPerDay: 100,
        images: ['https://images.unsplash.com/photo-1558978806-73073843b15e']),
    BikeModel(
        id: 'sample-24',
        name: 'Thunderbolt',
        types: [BikeType.special],
        status: BikeStatus.ide,
        lastRegisteredLocation: LocationModel(
            latitude: 51.433731,
            longitude: 5.477835,
            address: 'Philips Stadium, Eindhoven'),
        rentalPointsPerDay: 100,
        images: ['https://images.unsplash.com/photo-1487113991643-86bfb4c9de2d']),
    BikeModel(
        id: 'sample-25',
        name: 'Midnight Shadow',
        types: [BikeType.special],
        status: BikeStatus.ide,
        lastRegisteredLocation: LocationModel(
            latitude: 51.433731,
            longitude: 5.477835,
            address: 'Philips Stadium, Eindhoven'),
        rentalPointsPerDay: 100,
        images: ['https://images.unsplash.com/photo-1517482359597-b3f5ba0d52ce']),
    BikeModel(
        id: 'sample-26',
        name: 'Phoenix Fury',
        types: [BikeType.special],
        status: BikeStatus.ide,
        lastRegisteredLocation: LocationModel(
            latitude: 51.433731,
            longitude: 5.477835,
            address: 'Philips Stadium, Eindhoven'),
        rentalPointsPerDay: 100,
        images: ['https://images.unsplash.com/photo-1517208268027-690eee3d356f']),
    BikeModel(
        id: 'sample-27',
        name: 'Silver Bullet',
        types: [BikeType.special],
        status: BikeStatus.ide,
        lastRegisteredLocation: LocationModel(
            latitude: 51.433731,
            longitude: 5.477835,
            address: 'Philips Stadium, Eindhoven'),
        rentalPointsPerDay: 100,
        images: ['https://images.unsplash.com/photo-1517676284413-49b63f9007fe']),
  ];
}
