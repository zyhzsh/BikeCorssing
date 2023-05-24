import 'package:BikeCrossing/models/location_model.dart';
import 'package:BikeCrossing/models/rental_contract_model.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class HistoryRecordModel {
  final String id;
  final String bikeId;
  final String userId;
  final TypeOfRecord recordType;
  final List<String> imgUrls;
  final String content;
  final DateTime createdAt;
  final LocationModel location;

  HistoryRecordModel({
    required this.location,
    String? id,
    required this.bikeId,
    required this.userId,
    required this.recordType,
    required this.imgUrls,
    required this.content,
    DateTime? createdAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        id = id ?? uuid.v4();
}

enum TypeOfRecord {
  donate,
  returned,
  rent,
  storyShare,
  selfMaintenance,
  repairMaintenance,
}
