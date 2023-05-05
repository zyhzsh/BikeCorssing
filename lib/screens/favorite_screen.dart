import 'package:BikeCrossing/utilities/bike_type_extension.dart';
import 'package:flutter/cupertino.dart';

import '../models/bike_model.dart';
import '../widgets/custom_chip.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: 10),
          _BikeTypeFilters(),
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