import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  const CustomChip(
      {Key? key, required this.label, this.isSelected = false, this.onTap})
      : super(key: key);

  final String label;
  final bool isSelected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSelected
                ? Theme.of(context).colorScheme.secondaryContainer
                : Theme.of(context)
                    .colorScheme
                    .secondaryContainer
                    .withOpacity(0.2),
          ),
          child: Center(
            child: Text(label,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected
                          ? Theme.of(context).colorScheme.onSecondary
                          : Theme.of(context).colorScheme.onBackground,
                    )),
          )),
    );
  }
}
