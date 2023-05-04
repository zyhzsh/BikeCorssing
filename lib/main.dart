import 'package:BikeCrossing/screens/home_screen.dart';
import 'package:BikeCrossing/screens/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
//    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 50, 201, 169),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool isOnBoarding = true;

  void _skipOnBoarding() {
    setState(() {
      isOnBoarding = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: isOnBoarding?IntroductionScreen(
        onSkipOnBoarding: _skipOnBoarding,
      ):HomeScreen(),
    );
  }
}
