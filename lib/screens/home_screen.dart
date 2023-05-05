import 'package:BikeCrossing/screens/bikes_screen.dart';
import 'package:BikeCrossing/screens/journey_screen.dart';
import 'package:BikeCrossing/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int selectedScreenIndex=0;
  void _onSwitchScreen(int selectedIndex){
    setState(() {
      selectedScreenIndex = selectedIndex;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text('Bikes',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  )),
        ),
      ),
      body: [
        BikesScreen(),
        JourneyScreen(),
      ][selectedScreenIndex],
      bottomNavigationBar:  CustomBottomNavBar(
        selectedIndex: selectedScreenIndex,
        onSelectedScreen: _onSwitchScreen,
      ),
    );
  }
}



