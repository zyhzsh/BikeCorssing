import 'package:BikeCrossing/models/location_model.dart';

class HistoryRecordModel {
  final String id;
  final String bikeId;
  final String userId;
  final TypeOfRecord recordType;
  final List<String> imgUrls;
  final String content;
  final DateTime createdAt;
  final LocationModel location;

  const HistoryRecordModel( {
    required this.location,
    required this.id,
    required this.bikeId,
    required this.userId,
    required this.recordType,
    required this.imgUrls,
    required this.content,
    required this.createdAt,
  });


}


enum TypeOfRecord {
  donate,
  returned,
  rent,
  storyShare,
  selfMaintenance,
  repairMaintenance,
}
