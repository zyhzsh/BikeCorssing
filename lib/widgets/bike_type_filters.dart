import 'package:BikeCrossing/providers/biketype_filters_provider.dart';
import 'package:BikeCrossing/utilities/bike_type_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/bike_model.dart';
import '../providers/bikes_provider.dart';
import 'custom_chip.dart';

class BikeTypeFilters extends ConsumerWidget {
  const BikeTypeFilters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeBikeTypes = ref.watch(filtersProvider);
    final activeFilters = ref.read(filtersProvider.notifier).activeFilters;
    final setFilter = ref.read(filtersProvider.notifier).setFilter;
    final reLoadBikes = ref.read(bikesProvider.notifier).getBikesByTypes;
    return SizedBox(
      height: 30,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          ...BikeType.values.map((bikeType) => CustomChip(
              label: bikeType.capitalName(),
              isSelected: activeBikeTypes[bikeType] ?? false,
              onTap: () {
                setFilter(bikeType, !activeBikeTypes[bikeType]!);
                reLoadBikes(activeFilters());
              })),
        ],
      ),
    );
  }
}
