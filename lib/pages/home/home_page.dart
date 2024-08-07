import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_stream/configs/app_colors.dart';
import 'package:movie_stream/configs/app_styles.dart';
import 'package:movie_stream/pages/home/favorite_screen.dart';
import 'package:movie_stream/pages/home/home_screen.dart';
import 'package:movie_stream/pages/home/personal_screen.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/HomePage';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    const FavoriteScreen(),
    const PersonalScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: AppColors.bottomNavColor,
          height: 63,
          elevation: 2.0,
          indicatorColor: AppColors.primaryColor,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          labelTextStyle: WidgetStateProperty.all(
            AppStyles.heading4
          ),
        ),
        child: NavigationBar(
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          destinations: const <NavigationDestination>[
            NavigationDestination(
              icon: Icon(
                size: 20,
                Icons.home_outlined,
                color: Colors.white,
              ),
              label: "Home",
              selectedIcon: Icon(
                size: 20,
                Icons.home,
                color: Colors.white,
              ),
            ),
            NavigationDestination(
              icon: Icon(
                size: 20,
                Icons.favorite_outline,
                color: Colors.white,
              ),
              label: "Favourite",
              selectedIcon: Icon(
                size: 20,
                Icons.favorite,
                color: Colors.white,
              ),
            ),
            NavigationDestination(
              icon: Icon(
                size: 20,
                Icons.person_2_outlined,
                color: Colors.white,
              ),
              label: "Personal",
              selectedIcon: Icon(
                size: 20,
                Icons.person_2,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: IndexedStack(
        children: screens,
        index: currentPageIndex,
      ),
    );
  }
}
