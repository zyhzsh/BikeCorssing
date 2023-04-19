import 'package:BikeCorssing/screens/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
void main() {
  runApp(const MyApp());
}
final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const IntroductionScreen();
      },
    ),
  ],
);




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}

