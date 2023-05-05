
import 'package:BikeCrossing/screens/home_screen.dart';
import 'package:BikeCrossing/screens/introduction_screen.dart';
import 'package:BikeCrossing/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
//    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 50, 201, 169),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

Future<void> main() async {
  //Loading Environment variable file
  await dotenv.load(fileName: ".env");
  final supabaseUrl = dotenv.env['SUPABASE_URL'];
  final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'];
  await Supabase.initialize(
    url: supabaseUrl!,
    anonKey: supabaseAnonKey!,
  );
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
  late bool isLogin;

  void _onCompleteOnBoarding() {
    setState(() {
      isOnBoarding = false;
    });
  }

  void _onSuccessfulLogIn() {
    setState(() {
      isLogin = true;
    });
  }

  @override
  void initState() {
    super.initState();
    isLogin = Supabase.instance.client.auth.currentSession != null;
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: isOnBoarding
          ? IntroductionScreen(
              onCompleteOnBoarding: _onCompleteOnBoarding,
            )
          : isLogin
              ? HomeScreen()
              : LogInScreen(onSuccessfulLogIn:_onSuccessfulLogIn),
    );
  }
}
