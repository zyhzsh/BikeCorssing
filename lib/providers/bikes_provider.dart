import 'package:BikeCrossing/models/bike_model.dart';
import 'package:BikeCrossing/repositories/bike_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




class BikesNotifier extends StateNotifier<List<BikeModel>> {
  BikesNotifier() : super([]);
  final BikeRepository _bikeRepository = BikeRepository();

  Future<void> getBikes() async{
    final bikes = await _bikeRepository.getBikes();
    state = bikes;
  }

  Future<void> getBikesByTypes(List<BikeType> types) async{
    if(types.isEmpty) {
      getBikes();
      return;
    }
    final bikes = await _bikeRepository.getBikesByTypes(types);
    state = bikes;
  }

  Future<BikeModel> getBikeById(String id) async{
    final bike = await _bikeRepository.getBikeById(id);
    return bike;
  }
}


final bikesProvider = StateNotifierProvider<BikesNotifier, List<BikeModel>>(
    (ref) => BikesNotifier());
