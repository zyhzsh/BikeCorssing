import 'package:BikeCrossing/models/history_record_model.dart';
import 'package:BikeCrossing/providers/bikes_provider.dart';
import 'package:BikeCrossing/providers/profile_provider.dart';
import 'package:BikeCrossing/utilities/bike_type_extension.dart';
import 'package:BikeCrossing/widgets/bike_history_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/bike_model.dart';
import '../widgets/custom_chip.dart';

class JourneyScreen extends ConsumerStatefulWidget {
  const JourneyScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _JourneyScreenState();
  }
}

class _JourneyScreenState extends ConsumerState<JourneyScreen> {
  List<HistoryRecordModel> list = [];


  void getLists()async{
    //final bikes = ref.read(bikesProvider.notifier);
    //1.Get current user id
    final user = ref.read(userProfileProvider.notifier).state;
    final userId = user.id;
    //2.Get list of user contracts as a list of bike ids
    final userContracts = user.rentalContracts;
    print('userContracts');
    print(userContracts);

    final listOfBikeIds = userContracts.map((contract) => contract.bikeId).toList();
    //3.Get list of bikeHistory
    List<HistoryRecordModel> listOfBikeHistory = [];
    for (String bikeId in listOfBikeIds) {
      List<HistoryRecordModel> bikeHistory =  await ref.read(bikesProvider.notifier).getUserHistoryRecordsWithBike(bikeId, userId);
      listOfBikeHistory.addAll(bikeHistory);
    }
    setState(() {
      list = listOfBikeHistory;
    });

  }

  @override
  void initState() {

    super.initState();
    getLists();
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10),
          //_BikeTypeFilters(),
          SizedBox(height: 10),
          BikeHistoryList(
            withUserSection: false,
            historyRecords: list,
          ),
        ],
      ),
    );;
  }
}


class _BikeTypeFilters extends StatelessWidget {
  const _BikeTypeFilters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          ...BikeType.values.map((bikeType) =>
              CustomChip(label: bikeType.capitalName(), isSelected: false)),
        ],
      ),
    );
  }
}