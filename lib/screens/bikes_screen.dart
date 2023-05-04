import 'package:BikeCrossing/utilities/bike_type_extension.dart';
import 'package:BikeCrossing/widgets/custom_chip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/bike_model.dart';
import '../widgets/bike_preview_grid_card.dart';

class BikesScreen extends StatelessWidget {
  const BikesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: 10),
          _SearchBar(),
          SizedBox(height: 10),
          _BikeTypeFilters(),
          SizedBox(height: 10),
          _BikePreviewGrid(),
        ],
      ),
    );
  }
}


class _BikePreviewGrid extends StatelessWidget {
  const _BikePreviewGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.6,
      child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            mainAxisSpacing: 10.0,
          ),
          itemCount: 10,
          itemBuilder: ((context, index) {
            return BikePreviewGridCard(
              bike: BikeModel.sampleBikes[0],
              width: size.width * 0.425,
            );
          })),
    );
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

class _SearchBar extends StatelessWidget {
  const _SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextFormField(
          onChanged: (value) {},
          decoration: InputDecoration(
            hintText: 'Search bike',
            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Theme.of(context)
                .colorScheme
                .secondaryContainer
                .withOpacity(0.2),
          )),
    );
  }
}
