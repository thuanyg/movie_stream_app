import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_stream/configs/app_colors.dart';
import 'package:movie_stream/configs/app_styles.dart';
import 'package:movie_stream/dto/response/user_info_response.dart';
import 'package:movie_stream/dto/response/verify_token_response.dart';
import 'package:movie_stream/networks/retry_connection.dart';
import 'package:movie_stream/providers/auth/login_provider.dart';
import 'package:movie_stream/providers/user/user_provider.dart';
import 'package:movie_stream/ui/pages/home/home_page.dart';
import 'package:movie_stream/ui/pages/login/login_page.dart';
import 'package:movie_stream/ui/pages/onboarding_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const String routeName = '/SplashPage';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late LoginProvider loginProvider;

  @override
  void initState() {
    super.initState();
    loginProvider = Provider.of<LoginProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return AnimatedSplashScreen.withScreenFunction(
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
          ),
        ],
      ),
      screenFunction: () async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final bool isFirstRun = prefs.getBool('firstRun') ?? true;

        if (isFirstRun) {
          await prefs.setBool("firstRun", false);
          return const OnboardingPage();
        } else {
          VerifyTokenResponse? verifyTokenResponse =
              await retry(() => loginProvider.handleValidToken());

          if (verifyTokenResponse != null && verifyTokenResponse.valid) {
            String? id = verifyTokenResponse.userid.toString();
            await getUser(id);
            return const HomePage();
          }
          return const LoginPage();
        }
      },
      backgroundColor: AppColors.backgroundColor,
    );
  }

  Future<UserInfo?> getUser(String id) async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await userProvider.fetchUserByID(id);
    UserInfo? userInfo = userProvider.getUser;
    return userInfo;
  }
}
