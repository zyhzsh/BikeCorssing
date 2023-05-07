import 'package:BikeCrossing/providers/profile_provider.dart';
import 'package:BikeCrossing/screens/bikes_screen.dart';
import 'package:BikeCrossing/screens/favorite_screen.dart';
import 'package:BikeCrossing/screens/journey_screen.dart';
import 'package:BikeCrossing/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int selectedScreenIndex = 0;

  void _onSwitchScreen(int selectedIndex) {
    setState(() {
      selectedScreenIndex = selectedIndex;
    });
  }





  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(userProfileProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(currentUser.avatarUrl),
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    Text(
                      '${currentUser.remainingPoints} Points',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    )
                  ],
                )
              ],
            )),
      ),
      body: [
        BikesScreen(),
        JourneyScreen(),
        FavoriteScreen(),
      ][selectedScreenIndex],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: selectedScreenIndex,
        onSelectedScreen: _onSwitchScreen,
      ),
    );
  }
}
