import 'package:flutter/material.dart';
import 'package:movie_stream/pages/detail/detail_page.dart';
import 'package:movie_stream/pages/home/home_page.dart';
import 'package:movie_stream/pages/login/login_page.dart';
import 'package:movie_stream/pages/onboarding_page.dart';
import 'package:movie_stream/pages/splash_page.dart';

final Map<String, WidgetBuilder> routes = {
  SplashPage.routeName: (context) => const SplashPage(),
  OnboardingPage.routeName: (context) => const OnboardingPage(),
  LoginPage.routeName: (context) => const LoginPage(),
  HomePage.routeName: (context) => const HomePage(),
  DetailPage.routeName: (context) => const DetailPage(),
};
