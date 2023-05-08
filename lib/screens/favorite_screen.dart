import 'package:BikeCrossing/providers/profile_provider.dart';
import 'package:BikeCrossing/utilities/bike_type_extension.dart';
import 'package:BikeCrossing/widgets/bike_favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/bike_model.dart';
import '../providers/bikes_provider.dart';
import '../widgets/custom_chip.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteBikeIds = ref.watch(userProfileProvider).favoriteBikes;
    Future<List<BikeModel>> myFavoriteBikes =
        ref.read(bikesProvider.notifier).getBikesByIds(favoriteBikeIds);

  return  FutureBuilder<List<BikeModel>>(
    future: myFavoriteBikes,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        final favoriteBikes = snapshot.data;
        return ListView.builder(
          itemCount: favoriteBikes!.length,
          itemBuilder: (context, index) {
            final bike = favoriteBikes[index];
            return Container(
              margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                      image: DecorationImage(
                        image: NetworkImage(bike.images[0]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bike.name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            bike.rentalPointsPerDay.toString() + ' Points/Day',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10),
                          _BikeTypes(types:bike.types),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,10,10,0),
                    child: FavoriteButton(bikeId: bike.id),
                  )
                ],
                // Render other bike details as needed
              ),
            );
          },
        );
      }
    },
  );
  }
}


class _BikeTypes extends StatelessWidget {
  const _BikeTypes({Key? key, required this.types}) : super(key: key);

  final List<BikeType> types;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          ...types.map((bikeType) =>
              CustomChip(label: bikeType.capitalName())),
        ],
      ),
    );
  }
}
