import 'package:BikeCrossing/models/bike_model.dart';

//TODO: Get bikes from database
class BikeRepository {
  Future<List<BikeModel>> getBikes() async {
    await Future.delayed(const Duration(seconds: 1));
    return BikeModel.sampleBikes; // BikeModel.sampleBikes;
  }

  Future<List<BikeModel>> getBikesByTypes(List<BikeType> types) async {
    await Future.delayed(const Duration(seconds: 1));
    return BikeModel.sampleBikes;
  }

  Future<BikeModel> getBikeById(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    return BikeModel.sampleBikes.firstWhere((bike) => bike.id == id);
  }
}
