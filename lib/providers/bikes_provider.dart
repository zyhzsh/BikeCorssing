import 'package:BikeCrossing/models/bike_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BikesNotifier extends StateNotifier<List<BikeModel>> {
  BikesNotifier() : super([]);

  Future<void> getBikes() async {
    await Future.delayed(const Duration(seconds: 1));
    final bikes = BikeModel.sampleBikes;
    state = bikes;
  }

  Future<void> getBikesByTypes(List<BikeType> types) async {
    if (types.isEmpty) {
      getBikes();
      return;
    }
    await Future.delayed(const Duration(seconds: 1));
    final bikes = BikeModel.sampleBikes;
    state = bikes;
  }

  Future<BikeModel> getBikeById(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    final bike = BikeModel.sampleBikes.firstWhere((bike) => bike.id == id);
    return bike;
  }
}

final bikesProvider = StateNotifierProvider<BikesNotifier, List<BikeModel>>(
    (ref) => BikesNotifier());
