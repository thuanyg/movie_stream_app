import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_stream/configs/app_colors.dart';
import 'package:movie_stream/ui/pages/detail/detail_page.dart';
import 'package:movie_stream/ui/pages/login/login_page.dart';
import 'package:movie_stream/ui/pages/signup_page.dart';
import 'package:movie_stream/ui/pages/splash_page.dart';
import 'package:movie_stream/routes.dart';
import 'package:movie_stream/ui/pages/stream/stream_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Thay đổi màu thanh trạng thái và thanh điều hướng
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      // Màu của thanh trạng thái
      statusBarIconBrightness: Brightness.light,
      // Màu icon trong thanh trạng thái
      systemNavigationBarColor: Colors.transparent,
      // Màu của thanh điều hướng
      systemNavigationBarIconBrightness:
          Brightness.light, // Màu icon trong thanh điều hướng
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Movie Streaming App',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          scaffoldBackgroundColor: AppColors.backgroundColor),
      routes: routes,
      home: const LoginPage(),
    );
  }
}
