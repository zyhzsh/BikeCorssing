import 'package:BikeCrossing/models/location_model.dart';
import 'package:BikeCrossing/providers/location_provider.dart';
import 'package:BikeCrossing/screens/navigation_screen.dart';
import 'package:BikeCrossing/widgets/bike_favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';
import '../models/bike_model.dart';

class BikeDetail extends ConsumerWidget {
  const BikeDetail({Key? key, required this.bike}) : super(key: key);
  final BikeModel bike;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return FractionallySizedBox(
      heightFactor: 0.90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ImageCarousel(bike: bike),
          const SizedBox(height: 20),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _BasicInfo(bike: bike),
                  Divider(),
                  Container(
                    height: size.width * 0.74,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade200,
                    ),
                    child: Stack(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Center(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Placeholder(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 4,
                          right: 20,
                          left: 20,
                          child: ElevatedButton(
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
                              child: Text(bike.rentalPointsPerDay.toString() +
                                  ' Point / Day')),
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class _BasicInfo extends StatelessWidget {
  const _BasicInfo({
    super.key,
    required this.bike,
  });

  final BikeModel bike;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          bike.name,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Row(
              children: [
                const Icon(Icons.calendar_month),
                const SizedBox(width: 2),
                Text(
                  bike.formattedDate,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                const Icon(Icons.location_on),
                const SizedBox(width: 2),
                Container(
                  width: 220,
                  child: Text(
                    bike.lastRegisteredLocation.address,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Text(
              'Donated by: ',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(width: 2),
            Row(children: [
              CircleAvatar(
                maxRadius: 14,
                backgroundImage:
                    NetworkImage('http://via.placeholder.com/200x150'),
              ),
              SizedBox(width: 4),
              Text('Tom', style: Theme.of(context).textTheme.bodyMedium),
            ]),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Text(
              'Last Owner: ',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(width: 2),
            Row(children: [
              CircleAvatar(
                maxRadius: 14,
                backgroundImage:
                    NetworkImage('http://via.placeholder.com/200x150'),
              ),
              SizedBox(width: 4),
              Text('Tom', style: Theme.of(context).textTheme.bodyMedium),
            ]),
          ],
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.image),
                const SizedBox(width: 2),
                Text(
                  'x 4',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.transfer_within_a_station),
                const SizedBox(width: 2),
                Text(
                  'x 4',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.auto_fix_high),
                const SizedBox(width: 2),
                Text(
                  'x 4',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.build),
                const SizedBox(width: 2),
                Text(
                  'x 4',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _ImageCarousel extends StatelessWidget {
  const _ImageCarousel({
    super.key,
    required this.bike,
  });

  final BikeModel bike;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.32,
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
            right: 20,
            child: FavoriteButton(bikeId: bike.id,size: 20),
          ),
        ],
      ),
    );
  }
}
