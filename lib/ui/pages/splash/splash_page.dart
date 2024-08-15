import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_stream/configs/app_colors.dart';
import 'package:movie_stream/configs/app_styles.dart';
import 'package:movie_stream/networks/retry_connection.dart';
import 'package:movie_stream/providers/auth/login_provider.dart';
import 'package:movie_stream/providers/user/user_provider.dart';
import 'package:movie_stream/ui/pages/home/home_page.dart';
import 'package:movie_stream/ui/pages/login/login_page.dart';
import 'package:movie_stream/ui/pages/onboarding/onboarding_page.dart';
import 'package:movie_stream/utils/app_utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {

  static const String routeName = '/SplashPage';
  
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late LoginProvider loginProvider;

  @override
  void initState() {
    super.initState();
    loginProvider = Provider.of<LoginProvider>(context, listen: false);
    verifyUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              height: 70,
              "assets/animation/splash_animation.json",
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            Text(
              "Welcome to WatchEz",
              style: AppStyles.heading2.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> verifyUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isFirstRun = prefs.getBool('firstRun') ?? true;

    if (isFirstRun) {
      await prefs.setBool("firstRun", false);
      Navigator.pushReplacementNamed(context, OnboardingPage.routeName);
    } else {
      try {
        final verifyTokenResponse =
            await loginProvider.handleValidToken();

        if (verifyTokenResponse != null && verifyTokenResponse.valid) {
          String? id = verifyTokenResponse.userid.toString();
          final userProvider =
              Provider.of<UserProvider>(context, listen: false);
          await userProvider.fetchUserByID(id);

          if (userProvider.getUser != null) {
            Navigator.pushReplacementNamed(context, HomePage.routeName);
          } else {
            Navigator.pushReplacementNamed(context, LoginPage.routeName);
          }
        } else {
          Navigator.pushReplacementNamed(context, LoginPage.routeName);
        }
      } on Exception catch (e) {
        AppUtil.showErrorDialog(
            context: context,
            title: "Connection Failed",
            message: "Unable to connect to the server. Please check your internet connection and try again.",
            onPressAction: () async {
              Navigator.of(context).pop();
              await verifyUser();
            });
      }
    }
  }
}
