import 'package:BikeCrossing/models/bike_model.dart';
import 'package:BikeCrossing/models/history_record_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BikesNotifier extends StateNotifier<List<BikeModel>> {
  BikesNotifier() : super([]);

  Future<void> getBikes() async {
    await Future.delayed(const Duration(milliseconds: 200));
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
    await Future.delayed(const Duration(milliseconds: 200));
    final bike = BikeModel.sampleBikes.firstWhere((bike) => bike.id == id);
    return bike;
  }

  Future<List<BikeModel>> getBikesByIds(List<String> ids) async {
    final bikes = <BikeModel>[];
    for (final id in ids) {
      final bike = await getBikeById(id);
      bikes.add(bike);
    }
    return bikes;
  }

  Future<void> addBikeHistoryRecord(HistoryRecordModel record) async {
    state = [
      ...state.map((bike) {
        if (bike.id == record.bikeId) {
          bike.addHistoryRecord(record);
        }
        return bike;
      })
    ];
  }
}

final bikesProvider = StateNotifierProvider<BikesNotifier, List<BikeModel>>(
    (ref) => BikesNotifier());
