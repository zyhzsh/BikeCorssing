import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({Key? key,  this.size=20}) : super(key: key);

  final double? size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("Favorite"),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          size: size,
          Icons.favorite,
          color: Colors.white,
        ),
      ),
    );
  }
}
