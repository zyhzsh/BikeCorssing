import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'history_record_model.dart';

var uuid = Uuid();

class MiniQuestModel {
  final String? id;
  bool completionStatus;
  final TypeOfRecord typeOfRecord;
  final int earningPoints;
  final String subtitle;
   String bikeId;

  MiniQuestModel({
    String? id,
    required this.typeOfRecord,
    required this.completionStatus,
    required this.earningPoints,
    required this.subtitle,
    required this.bikeId,
  }) : id = id ?? uuid.v4();


  String get title{
    switch (typeOfRecord) {
      case TypeOfRecord.repairMaintenance:
        return 'Repair & Maintenance';
      case TypeOfRecord.selfMaintenance:
        return 'Self Maintenance';
      case TypeOfRecord.storyShare:
        return 'Story Share';
      default:
        return 'Unknown';
    }
  }

  Icon get icon {
    switch (typeOfRecord) {
      case TypeOfRecord.repairMaintenance:
        return Icon(Icons.build);
      case TypeOfRecord.selfMaintenance:
        return Icon(Icons.auto_fix_high);
      case TypeOfRecord.storyShare:
        return Icon(Icons.photo);
      default:
        return Icon(Icons.question_mark_rounded);
    }
  }


  static List<MiniQuestModel> sample = [
      MiniQuestModel(
        typeOfRecord: TypeOfRecord.repairMaintenance,
        completionStatus: false,
        earningPoints: 200,
        subtitle: 'Keep your ride smooth - maintain your bike!',
        bikeId: 'bikeId',
      ),
      MiniQuestModel(
        typeOfRecord: TypeOfRecord.selfMaintenance,
        completionStatus: false,
        earningPoints: 100,
        subtitle: 'A little maintenance goes a long way!',
        bikeId: 'bikeId',
      ),
      MiniQuestModel(
        typeOfRecord: TypeOfRecord.storyShare,
        completionStatus: false,
        earningPoints: 100,
        subtitle: 'Share your bicycle journey!',
        bikeId: 'bikeId',
      ),
    ];


  static List<MiniQuestModel> getSampleMiniQuests(String bikeId) {
    return sample.map((e){
      e.bikeId=bikeId;
      return e;
    }).toList();
  }
  static List<MiniQuestModel> modifyMiniQuests(String bikeId, TypeOfRecord typeOfRecord) {
    return sample.map((e){
      e.bikeId=bikeId;
      if(e.typeOfRecord==typeOfRecord){
        e.completionStatus=!e.completionStatus;
      }
      return e;
    }).toList();
  }
}
