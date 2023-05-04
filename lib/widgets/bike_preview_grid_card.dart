import 'package:flutter/cupertino.dart';

import '../models/bike_model.dart';

class BikePreviewGridCard extends StatelessWidget {
  const BikePreviewGridCard({Key? key, required this.bike, required this.width})
      : super(key: key);

  final BikeModel bike;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Image.network(
            bike.images[0],
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }
}
