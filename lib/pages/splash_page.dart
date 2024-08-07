import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_stream/configs/app_colors.dart';
import 'package:movie_stream/configs/app_styles.dart';
import 'package:movie_stream/pages/login/login_page.dart';
import 'package:movie_stream/pages/onboarding_page.dart';
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
      splash: Container(
        height: size.height,
        margin: const EdgeInsets.all(10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("assets/animation/splash_animation.json",
                  height: 48, width: 48, fit: BoxFit.fill),
              Text(
                "Welcome to WatchEz",
                style: AppStyles.heading2.copyWith(fontWeight: FontWeight.bold),
              )
            ]),
      ),
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
