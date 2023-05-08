import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/profile_provider.dart';

class FavoriteButton extends ConsumerWidget {
  const FavoriteButton({Key? key, this.size = 20, required this.bikeId})
      : super(key: key);

  final String bikeId;
  final double? size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite =
        ref.watch(userProfileProvider).favoriteBikes.contains(bikeId);

    return GestureDetector(
      onTap: () {
        ref.read(userProfileProvider.notifier).updateFavoriteBike(bikeId);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          size: size,
          Icons.favorite,
          color: isFavorite?Colors.redAccent:Colors.white,
        ),
      ),
    );
  }
}
