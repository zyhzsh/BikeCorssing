import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({Key? key, required this.onCompleteOnBoarding})
      : super(key: key);

  final void Function() onCompleteOnBoarding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/onboarding_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.45,
            bottom: MediaQuery.of(context).size.height * 0.1,
            left: 30,
            right: 30,
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hunting precious ',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontSize: 65,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                _ExploreButton(onCompleteOnBoarding: onCompleteOnBoarding),
              ]),
        ),
      ),
    );
  }
}

class _ExploreButton extends StatefulWidget {
  const _ExploreButton({
    super.key,
    required this.onCompleteOnBoarding,
  });

  final void Function() onCompleteOnBoarding;

  @override
  State<_ExploreButton> createState() => _ExploreButtonState();
}

class _ExploreButtonState extends State<_ExploreButton> {
  @override
  Widget build(BuildContext context) {
    final colorizeColors = [
      Colors.white,
      Theme.of(context).colorScheme.primary,
    ];

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.zero,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
        ),
        onPressed: widget.onCompleteOnBoarding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.arrow_circle_right_outlined,
              size: 50,
              color: Colors.white,
            ),
            AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  'Explore Now',
                  textStyle: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                  colors: colorizeColors,
                ),
              ],
              repeatForever: true,
              onTap: widget.onCompleteOnBoarding,
            ),
          ],
        ));
  }
}

