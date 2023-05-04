import 'package:BikeCrossing/models/bike_model.dart';

class BikeRepository {
  Future<List<BikeModel>> getBikes(BikeType type) async {
    await Future.delayed(const Duration(seconds: 1));
    return BikeModel.sampleBikes
        .where((bike) => bike.types.contains(type))
        .toList();
  }

  Future<BikeModel> getBike(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    return BikeModel.sampleBikes.firstWhere((bike) => bike.id == id);
  }
}
