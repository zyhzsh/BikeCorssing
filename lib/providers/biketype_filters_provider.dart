import 'package:BikeCrossing/models/bike_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bikes_provider.dart';

class BikeTypeFiltersNotifier extends StateNotifier<Map<BikeType, bool>> {
  BikeTypeFiltersNotifier() : super(kInitialFilters);

  static const kInitialFilters = {
    BikeType.road: false,
    BikeType.cruiser: false,
    BikeType.mountain: false,
    BikeType.touring: false,
    BikeType.special: false,
  };

  void setFilter(BikeType bikeType, bool isActive) {
    state = {...state, bikeType: isActive};
  }

  List<BikeType> activeFilters () {
    return state.entries.where((element) => element.value).map((e) => e.key).toList();
  }

}


final filtersProvider =
    StateNotifierProvider<BikeTypeFiltersNotifier, Map<BikeType, bool>>(
        (ref) => BikeTypeFiltersNotifier());

final filteredBikesProvider = Provider((ref) {
  final bikes = ref.watch(bikesProvider);
  final activeFilters = ref.watch(filtersProvider);

  return bikes.where((bike) {
    if (activeFilters[BikeType.road]! && !bike.types.contains(BikeType.road)) {
      return false;
    }
    if (activeFilters[BikeType.cruiser]! &&
        !bike.types.contains(BikeType.cruiser)) {
      return false;
    }
    if (activeFilters[BikeType.mountain]! &&
        !bike.types.contains(BikeType.mountain)) {
      return false;
    }
    if (activeFilters[BikeType.touring]! &&
        !bike.types.contains(BikeType.touring)) {
      return false;
    }
    if (activeFilters[BikeType.special]! &&
        !bike.types.contains(BikeType.special)) {
      return false;
    }
    return true;
  }).toList();
});


