import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(20, 0, 10, 20),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash_image_icon.png"),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children:[
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFFAACF69),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                  onPressed: () => context.go('/challenges'),
                  child: Container(
                    alignment: Alignment.center,
                    width: 320,
                    height: 60,
                    child: const Text(
                      "Start",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  )
              ),
              const SizedBox(height: 20),
            ]),
      ),
    );
  }
}
