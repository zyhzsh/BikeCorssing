import 'package:BikeCrossing/models/bike_model.dart';
import 'package:BikeCrossing/models/location_model.dart';
import 'package:BikeCrossing/providers/bikes_provider.dart';
import 'package:BikeCrossing/utilities/bike_history_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import '../models/history_record_model.dart';
import '../providers/profile_provider.dart';
import '../widgets/bike_event_cards.dart';
import '../widgets/bike_history_list.dart';

class ActiveContractScreen extends StatefulWidget {
  const ActiveContractScreen({Key? key}) : super(key: key);

  @override
  State<ActiveContractScreen> createState() => _ActiveContractScreenState();
}

class _ActiveContractScreenState extends State<ActiveContractScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //_Tabs
        _Tabs(tabController: tabController),
        //_Body
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: const [
              _ContractInfo(),
              _MiniQuest(),
              _BikeStory(),
            ],
          ),
        ),
      ],
    );
  }
}

class _BikeStory extends ConsumerWidget {
  const _BikeStory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWith = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;
    final bikeId = ref.watch(userProfileProvider).currentContract!.bikeId;
    final bike = ref.read(bikesProvider.notifier).getBikeById(bikeId!);

    return FutureBuilder(
      future: bike,
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          BikeModel bike = snapshot.data as BikeModel;
          return Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              EventCards(
                  storyShareTimes: bike
                      .getHistoryEventTimes(TypeOfRecord.storyShare)
                      .toString(),
                  bike: bike,
                  exchangeTimes: bike
                      .getHistoryEventTimes(TypeOfRecord.returned)
                      .toString(),
                  selfMaintenanceTimes: bike
                      .getHistoryEventTimes(TypeOfRecord.selfMaintenance)
                      .toString(),
                  repairMaintenanceTimes: bike
                      .getHistoryEventTimes(TypeOfRecord.repairMaintenance)
                      .toString()),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: BikeHistoryList(
                    historyRecords: bike.historyRecords,
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class _MiniQuest extends StatelessWidget {
  const _MiniQuest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _Tabs extends StatefulWidget {
  const _Tabs({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  State<_Tabs> createState() => _TabsState();
}

class _TabsState extends State<_Tabs> {
  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: const [
        Tab(
          text: 'Info',
        ),
        Tab(
          text: 'Quest',
        ),
        Tab(
          text: 'Story',
        )
      ],
      controller: widget.tabController,
      indicatorSize: TabBarIndicatorSize.tab,
    );
  }
}

class _ContractInfo extends ConsumerWidget {
  const _ContractInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWith = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;
    final activeContract = ref.watch(userProfileProvider).currentContract;
    final getBike =
        ref.read(bikesProvider.notifier).getBikeById(activeContract!.bikeId);
    return SingleChildScrollView(
        child: FutureBuilder(
            future: getBike,
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                BikeModel bike = snapshot.data as BikeModel;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: currentWith * 0.8,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: NetworkImage(bike.images[0]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(bike.name,
                        style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        'Return before:  ${activeContract.returnDate.year}-${activeContract.returnDate.month}-${activeContract.returnDate.day}',
                        style: Theme.of(context).textTheme.bodyMedium),
                    SizedBox(
                      height: 10,
                    ),
                    QrImage(
                      data: 'contractId:${activeContract.id}',
                      version: QrVersions.auto,
                      size: currentWith * 0.5,
                    ),
                    Text('Return code',
                        style: Theme.of(context).textTheme.bodyMedium),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        width: currentWith * 0.5,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              foregroundColor: Colors.white,
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.search,
                                  size: 30,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Find return point',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ))),
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            }));
  }
}
