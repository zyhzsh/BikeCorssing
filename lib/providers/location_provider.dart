
import 'package:BikeCrossing/models/location_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationNotifier extends StateNotifier<LocationModel> {
  LocationNotifier() : super(LocationModel.sampleLocation);

  Future<void> getCurrentLocation() async {
    //TODO: get current user profile from supabase
    await Future.delayed(const Duration(seconds: 1));
    state = LocationModel.sampleLocation;
  }
}

final userLocationProvider = StateNotifierProvider<LocationNotifier,LocationModel>(
        (ref) => LocationNotifier());
