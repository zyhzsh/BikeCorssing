import 'package:BikeCrossing/widgets/bike_preview_grid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/bike_type_filters.dart';

class BikesScreen extends StatelessWidget {
  const BikesScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: const [
          SizedBox(height: 10),
          _SearchBar(),
          SizedBox(height: 10),
          BikeTypeFilters(),
          SizedBox(height: 10),
          BikePreviewGrid(),
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
