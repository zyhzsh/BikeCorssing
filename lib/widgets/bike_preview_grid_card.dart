import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/bike_model.dart';
import '../providers/bikes_provider.dart';
import 'bike_detail.dart';

class BikePreviewGridCard extends ConsumerStatefulWidget {
  const BikePreviewGridCard({
    Key? key,
    required this.bike,
    required this.width,
  }) : super(key: key);

  final BikeModel bike;
  final double width;

  @override
  ConsumerState<BikePreviewGridCard> createState() =>
      _BikePreviewGridCardState();
}

class _BikePreviewGridCardState extends ConsumerState<BikePreviewGridCard> {
  late final ImageProvider _imageProvider = NetworkImage(widget.bike.images[0]);
  late BuildContext dialogContext;


  void _showBikeDetail() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    final bike = await ref.read(bikesProvider.notifier).getBikeById(widget.bike.id);
    Navigator.of(context).pop();
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => BikeDetail(bike: bike));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showBikeDetail(),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: _imageProvider,
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
                    Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: () => print("Favorite"),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.bike.name,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  Text(
                    '${widget.bike.rentalPointsPerDay} Points/Day',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 16,
                      ),
                      Text(widget.bike.lastRegisteredLocation.address,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                  )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
