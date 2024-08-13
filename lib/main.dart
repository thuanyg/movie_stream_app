import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_stream/configs/app_colors.dart';
import 'package:movie_stream/providers/auth/login_provider.dart';
import 'package:movie_stream/providers/auth/signup_provider.dart';
import 'package:movie_stream/providers/movie/movie_provider.dart';
import 'package:movie_stream/providers/user/user_provider.dart';
import 'package:movie_stream/repository/auth_repositoy.dart';
import 'package:movie_stream/repository/movie_repository.dart';
import 'package:movie_stream/repository/user_repository.dart';
import 'package:movie_stream/repository/verify_token_repository.dart';
import 'package:movie_stream/routes.dart';
import 'package:movie_stream/ui/pages/home/home_page.dart';
import 'package:movie_stream/ui/pages/stream/stream_page.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Thay đổi màu thanh trạng thái và thanh điều hướng
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.bottomNavColor,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) => LoginProvider(AuthRepository(), VerifyRepository())),
      ChangeNotifierProvider(create: (_) => SignupProvider(UserRepository())),
      ChangeNotifierProvider(create: (_) => UserProvider(UserRepository())),
      ChangeNotifierProvider(create: (_) => MovieProvider(MovieRepository())),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Streaming App',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          scaffoldBackgroundColor: AppColors.backgroundColor),
      routes: routes,
      home: const HomePage(),
    );
  }
}
