import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_stream/configs/app_colors.dart';
import 'package:movie_stream/configs/app_styles.dart';
import 'package:movie_stream/ui/pages/login/login_page.dart';
import 'package:movie_stream/ui/pages/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const String routeName = '/SplashPage';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return AnimatedSplashScreen.withScreenFunction(
      duration: 2000,
      splash: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 50,
              child: Lottie.asset(
                "assets/animation/splash_animation.json",
                fit: BoxFit.contain,
              ),
            ),
            Text(
              "Welcome to WatchEz",
              style: AppStyles.heading2.copyWith(fontWeight: FontWeight.bold),
            )
          ]),
      screenFunction: () async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final bool isFirstRun = prefs.getBool('firstRun') ?? true;

        if (isFirstRun) {
          await prefs.setBool("firstRun", false);
          return const OnboardingPage();
        } else {
          return const LoginPage();
        }
      },
      backgroundColor: AppColors.backgroundColor,
    );
  }
}
