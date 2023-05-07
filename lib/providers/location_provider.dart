import 'package:BikeCrossing/models/location_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';

class LocationService {
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  Location location = Location();
  LocationData? _locationData;

  LocationService({
    bool serviceEnabled = false,
    PermissionStatus permissionGranted = PermissionStatus.denied,
    LocationData? locationData,
  })  : _serviceEnabled = serviceEnabled,
        _permissionGranted = permissionGranted,
        _locationData = locationData;

  void _enableService() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
  }
  void _enablePermission() async {
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }


  Future<LocationData?> getLocation() async {
     _enableService();
     _enablePermission();
    try {
      _locationData = await location.getLocation();
      return _locationData;
    } catch (e) {
      print(e);
    }
    return null;
  }
}

class LocationNotifier extends StateNotifier<LocationModel> {
  LocationNotifier() : super(LocationModel.sampleLocation);
  Future<LocationModel> getCurrentLocation() async {
    LocationService locationService = LocationService();
    final data = await locationService.getLocation();
    if (data != null) {
      state = LocationModel(
        latitude: data.latitude!,
        longitude: data.longitude!,
        address: 'Unknown',
      );
    }
    return state;
  }


}

final userLocationProvider =
    StateNotifierProvider<LocationNotifier, LocationModel>(
        (ref) => LocationNotifier());
