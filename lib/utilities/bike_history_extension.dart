import 'package:BikeCrossing/models/bike_model.dart';
import 'package:flutter/material.dart';

import '../models/history_record_model.dart';

extension BikeTypeExtension on BikeModel {
  int getHistoryEventTimes(TypeOfRecord type) {
    int times = 0;
    if (type == TypeOfRecord.donate) return 1;
    if (type == TypeOfRecord.returned) times = 1;
    for (HistoryRecordModel h in historyRecords) {
      if (h.recordType == type) {
        times++;
      }
    }
    return times;
  }
}

extension HistoryIconExtension on TypeOfRecord {
  Icon getIcon() {
    switch (this) {
      case TypeOfRecord.donate:
        return Icon(
          Icons.transfer_within_a_station,
          color: Colors.black,
        );
      //return 'assets/icons/donate.svg';
      case TypeOfRecord.rent:
        return Icon(
          Icons.transfer_within_a_station,
          color: Colors.black,
        );
      //return 'assets/icons/rent.svg';
      case TypeOfRecord.returned:
        //return 'assets/icons/return.svg';
        return Icon(
          Icons.transfer_within_a_station,
          color: Colors.black,
        );
      case TypeOfRecord.selfMaintenance:
        //return 'assets/icons/maintenance.svg';
        return Icon(
          Icons.auto_fix_high,
          color: Colors.black,
        );
      case TypeOfRecord.repairMaintenance:
        //return 'assets/icons/maintenance.svg';
        return Icon(
          Icons.build,
          color: Colors.black,
        );
      case TypeOfRecord.storyShare:
        return Icon(
          Icons.image,
          color: Colors.black,
        );
      //return 'assets/icons/story.svg';
    }
  }
}
