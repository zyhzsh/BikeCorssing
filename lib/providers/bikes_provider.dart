import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:BikeCrossing/models/bike_model.dart';
import 'package:BikeCrossing/models/history_record_model.dart';
import 'package:BikeCrossing/utilities/bike_history_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

var uuid = Uuid();

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
          print(bike.getHistoryEventTimes(TypeOfRecord.rent));
        }
        return bike;
      })
    ];
  }

  Future<List<HistoryRecordModel>> getUserHistoryRecordsWithBike(String bikeId , String userId) async {
    final bike = await getBikeById(bikeId);
    return bike.historyRecords.where((record) => record.userId == userId).toList();
  }

  Future<List<String>> uploadBikeImages(
      String bikeId, List<File> images) async {
    List<String> uploadedImagesPath = [];
    for (File file in images) {
      final image = File(file.path);
      final path = 'public/$bikeId/${uuid.v4()}';
      await Supabase.instance.client.storage
          .from('images')
          .upload(
            path,
            image,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );
      final url = Supabase.instance.client.storage
          .from('images')
          .getPublicUrl(path);
      uploadedImagesPath.add(url);
    }
    return uploadedImagesPath;
  }
}

final bikesProvider = StateNotifierProvider<BikesNotifier, List<BikeModel>>(
    (ref) => BikesNotifier());
