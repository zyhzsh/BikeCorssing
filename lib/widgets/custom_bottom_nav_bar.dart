import 'package:BikeCrossing/providers/profile_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/rental_contract_model.dart';
//import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavBar extends ConsumerStatefulWidget {
  const CustomBottomNavBar({Key? key, required this.selectedIndex, required this.onSelectedScreen}) : super(key: key);
  final int selectedIndex;
  final void Function(int) onSelectedScreen;

  @override
  ConsumerState<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends ConsumerState<CustomBottomNavBar> {

  List<NavigationDestination> navOptions =  [
    //TODO: Adding custom svg icon for the navigation tab
    const NavigationDestination(
      //icon:SvgPicture.asset('assets/icons/1.svg'),
      icon: Icon(Icons.directions_bike),
      label: 'Bikes',
    ),
    const NavigationDestination(
      icon: Icon(Icons.book),
      label: 'Journey',
    ),
    const NavigationDestination(
      icon: Icon(Icons.favorite),
      label: 'Favorite',
    ),
  ];
  List<NavigationDestination> defaultOptions =  [
    //TODO: Adding custom svg icon for the navigation tab
    const NavigationDestination(
      //icon:SvgPicture.asset('assets/icons/1.svg'),
      icon: Icon(Icons.directions_bike),
      label: 'Bikes',
    ),
    const NavigationDestination(
      icon: Icon(Icons.book),
      label: 'Journey',
    ),
    const NavigationDestination(
      icon: Icon(Icons.favorite),
      label: 'Favorite',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final currentContract = ref.watch(userProfileProvider).currentContract;
    if (currentContract!=null&&currentContract.status==ContractStatus.active) {
      setState(() {
        navOptions[0] = const NavigationDestination(
          //icon:SvgPicture.asset('assets/icons/1.svg'),
          icon: Icon(Icons.library_books_sharp),
          label: 'Contract',
        );
      });
    }else{
      setState(() {
        navOptions = defaultOptions;
      });
    }
    return NavigationBar(
      onDestinationSelected: widget.onSelectedScreen,
      selectedIndex: widget.selectedIndex,
      destinations: [
        for (final destination in navOptions)
          NavigationDestination(
            icon: destination.icon,
            label: destination.label,
          ),
      ],
    );
  }
}

