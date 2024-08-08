import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_stream/configs/app_colors.dart';
import 'package:movie_stream/configs/app_styles.dart';
import 'package:movie_stream/ui/pages/home/favorite_screen.dart';
import 'package:movie_stream/ui/pages/home/home_screen.dart';
import 'package:movie_stream/ui/pages/home/personal_screen.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/HomePage';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  final PageController _pageController = PageController();

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
          data: const NavigationBarThemeData(
            backgroundColor: AppColors.bottomNavColor,
            height: 63,
            elevation: 2.0,
            indicatorColor: Colors.transparent,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            // labelTextStyle: WidgetStateProperty.all(AppStyles.heading4),
          ),
          child: NavigationBar(
            selectedIndex: currentPageIndex,
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
                _pageController.jumpToPage(index); // Update PageView to the selected page
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
                  size: 24,
                  Icons.home,
                  color: Color(0xff54A8E5),
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
                  size: 24,
                  Icons.favorite,
                  color: Color(0xff54A8E5),
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
                  size: 24,
                  Icons.person_2,
                  color: Color(0xff54A8E5),
                ),
              ),
            ],
          ),
        ),
        body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: screens));
  }

}
