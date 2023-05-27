import 'package:uuid/uuid.dart';

var uuid = Uuid();

class RentalContractModel {
  final String id;
  final String bikeId;
  final String userId;
  final DateTime createdAt;
  final DateTime returnDate;
  ContractStatus status;
  final int costPointPerDay;

  RentalContractModel({
    String? id,
    required this.bikeId,
    required this.userId,
    required this.returnDate,
    ContractStatus? status,
    required this.costPointPerDay,
    DateTime? createAt,
  })  : status = status ?? ContractStatus.draft,
        id = id ?? uuid.v4(),
        createdAt = createAt ?? DateTime.now();

  void updateContractStatus(ContractStatus status){
    this.status = status;
  }

}

enum ContractStatus {
  draft,
  active,
  approved,
  terminated,
  expired,
}

