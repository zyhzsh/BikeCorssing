import 'package:BikeCrossing/models/bike_model.dart';

extension BikeTypeExtension on BikeType {
  String capitalName() =>
      name[0].toString().toUpperCase() + name.substring(1, name.length);
}
