import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({Key? key, required this.selectedIndex, required this.onSelectedScreen}) : super(key: key);
  final int selectedIndex;
  final void Function(int) onSelectedScreen;

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {

  static List<NavigationDestination> allDestinations = const [
    //TODO: Adding custom svg icon for the navigation tab
    NavigationDestination(
      //icon:SvgPicture.asset('assets/icons/1.svg'),
      icon: Icon(Icons.bike_scooter),
      label: 'Bike',
    ),
    NavigationDestination(
      icon: Icon(Icons.book),
      label: 'Journey',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: widget.onSelectedScreen,
      selectedIndex: widget.selectedIndex,
      destinations: [
        for (final destination in allDestinations)
          NavigationDestination(
            icon: destination.icon,
            label: destination.label,
          ),
      ],
    );
  }
}

