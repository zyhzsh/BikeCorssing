import 'package:BikeCrossing/models/history_record_model.dart';
import 'package:BikeCrossing/models/location_model.dart';
import 'package:BikeCrossing/models/profile_model.dart';
import 'package:BikeCrossing/providers/location_provider.dart';
import 'package:BikeCrossing/providers/profile_provider.dart';
import 'package:BikeCrossing/screens/navigation_screen.dart';
import 'package:BikeCrossing/utilities/bike_history_extension.dart';
import 'package:BikeCrossing/widgets/bike_favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/bike_model.dart';
import 'bike_event_cards.dart';
import 'bike_history_list.dart';

class BikeDetail extends ConsumerWidget {
  const BikeDetail({Key? key, required this.bike}) : super(key: key);
  final BikeModel bike;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final bikeDonor =
        ref.read(userProfileProvider.notifier).getProfileById(bike.donorId);

    final storyShareTimes =
        bike.getHistoryEventTimes(TypeOfRecord.storyShare).toString();
    final exchangeTimes =
        bike.getHistoryEventTimes(TypeOfRecord.rent).toString();
    final selfMaintenanceTimes =
        bike.getHistoryEventTimes(TypeOfRecord.selfMaintenance).toString();
    final repairMaintenanceTimes =
        bike.getHistoryEventTimes(TypeOfRecord.repairMaintenance).toString();

    return FractionallySizedBox(
      heightFactor: 0.90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // _Bike Name card
          _BikeNameCard(size: size, bike: bike, bikeDonor: bikeDonor),
          // _EventsCards
          SizedBox(height: size.height * 0.012),
          EventCards(
              storyShareTimes: storyShareTimes,
              bike: bike,
              exchangeTimes: exchangeTimes,
              selfMaintenanceTimes: selfMaintenanceTimes,
              repairMaintenanceTimes: repairMaintenanceTimes),
          // _HistoryRecordList
          SizedBox(height: size.height * 0.012),
          Stack(
            children: [
              SizedBox(
                width: size.width,
                height: size.height * 0.54,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      BikeHistoryList(
                        historyRecords: bike.historyRecords,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    ],
                  ),
                ),
              ),
              // _ Button
              Positioned(
                bottom: 0,
                child: Container(
                  width: size.width,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                      ),
                      onPressed: () async {
                        LocationModel currentLocation = await ref
                            .read(userLocationProvider.notifier)
                            .getCurrentLocation();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => NavigationScreen(
                                  startLocation: currentLocation,
                                  bike: bike,
                                )));
                      },
                      child: Text(
                          bike.rentalPointsPerDay.toString() + ' Point / Day')),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}



class _BikeNameCard extends StatelessWidget {
  const _BikeNameCard({
    super.key,
    required this.size,
    required this.bike,
    required this.bikeDonor,
  });

  final Size size;
  final BikeModel bike;
  final Future<UserProfileModel> bikeDonor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.3,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        image: DecorationImage(
          image: NetworkImage(bike.images[0]),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: Text(
              bike.name,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: FavoriteButton(bikeId: bike.id, size: 20),
          ),
          Positioned(
              bottom: 20,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Since: ' +
                        bike.createdAt!.year.toString() +
                        '-' +
                        bike.createdAt!.month.toString() +
                        '-' +
                        bike.createdAt!.day.toString(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'From: ' + bike.firstRegisteredLocation.address,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  FutureBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done) {
                        UserProfileModel user =
                        snapshot.data as UserProfileModel;

                        return Text(
                          'By: ' + user.userName,
                          style:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      } else {
                        return const Text('...');
                      }
                    },
                    future: bikeDonor,
                    initialData: {},
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
