import 'package:BikeCrossing/models/bike_model.dart';
import 'package:BikeCrossing/providers/bikes_provider.dart';
import 'package:BikeCrossing/providers/location_provider.dart';
import 'package:BikeCrossing/utilities/location_distance_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/biketype_filters_provider.dart';
import 'bike_preview_grid_card.dart';

class BikePreviewGrid extends ConsumerStatefulWidget {
  const BikePreviewGrid({Key? key}) : super(key: key);

  @override
  ConsumerState<BikePreviewGrid> createState() => _BikePreviewGridState();
}

class _BikePreviewGridState extends ConsumerState<BikePreviewGrid> {
  var _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadBikes();
  }

  void loadBikes() async {
    await ref.read(bikesProvider.notifier).getBikes();
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredBikes = ref.watch(filteredBikesProvider);
    final myLocation = ref.watch(userLocationProvider);
    final size = MediaQuery.of(context).size;

    Widget content = SizedBox(
        height: size.height * 0.4,
        child: const Center(child: Text('No bikes found')));
    if (_isLoading) {
      content = SizedBox(
          height: size.height * 0.4,
          child: const Center(child: CircularProgressIndicator()));
    }
    if (filteredBikes.isNotEmpty) {
      filteredBikes.sort((bike1, bike2) => myLocation
          .calculateDistanceInDouble(bike1.lastRegisteredLocation.latitude,
              bike1.lastRegisteredLocation.longitude)
          .compareTo(myLocation.calculateDistanceInDouble(
              bike2.lastRegisteredLocation.latitude,
              bike2.lastRegisteredLocation.longitude)));
      content = Expanded(
        child: SizedBox(
          height: size.height * 0.6,
          child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              itemCount: filteredBikes.length,
              itemBuilder: ((context, index) {
                return BikePreviewGridCard(
                  bike: filteredBikes[index],
                  width: size.width * 0.425,
                );
              })),
        ),
      );
    }

    return content;
  }
}
