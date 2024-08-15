import 'package:flutter/material.dart';
import 'package:movie_stream/ui/pages/detail/detail_page.dart';
import 'package:movie_stream/ui/pages/home/home_page.dart';
import 'package:movie_stream/ui/pages/login/login_page.dart';
import 'package:movie_stream/ui/pages/onboarding/onboarding_page.dart';
import 'package:movie_stream/ui/pages/search/search_page.dart';
import 'package:movie_stream/ui/pages/signup/signup_page.dart';
import 'package:movie_stream/ui/pages/splash/splash_page.dart';
import 'package:movie_stream/ui/pages/stream/stream_page.dart';

final Map<String, WidgetBuilder> routes = {
  SplashPage.routeName: (context) => const SplashPage(),
  OnboardingPage.routeName: (context) => const OnboardingPage(),
  LoginPage.routeName: (context) => const LoginPage(),
  HomePage.routeName: (context) => const HomePage(),
  DetailPage.routeName: (context) => const DetailPage(),
  MovieStreamPage.routeName: (context) => const MovieStreamPage(),
  SignupPage.routeName: (context) => const SignupPage(),
  SearchPage.routeName: (context) => const SearchPage()
};
