import 'dart:convert';

import 'package:BikeCrossing/models/location_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
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
    final lat = data!.latitude;
    final lng = data!.longitude;
    await dotenv.load(fileName: ".env");
    final apiKey = dotenv.env['GOOGLEMAPS_GEOLOCATION_API_KEY'];
    String geoQuery =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey';
    final url = Uri.parse(geoQuery);
    final response = await http.get(url);
    final resData = json.decode(response.body);
    final address = resData['results'][0]['formatted_address'];

    if (data != null) {
      state = LocationModel(
        latitude: lat!,
        longitude: lng!,
        address: address,
      );
    }
    return state;
  }


}

final userLocationProvider =
    StateNotifierProvider<LocationNotifier, LocationModel>(
        (ref) => LocationNotifier());
