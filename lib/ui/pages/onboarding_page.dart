import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_stream/configs/app_colors.dart';
import 'package:movie_stream/configs/app_styles.dart';
import 'package:movie_stream/configs/constaints.dart';
import 'package:movie_stream/helpers/image_helper.dart';
import 'package:movie_stream/ui/pages/login/login_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});
  static const String routeName = '/OnboardingPage';
  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final pageController = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: onboardingPages.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageHelper.loadAssetImage(
                      onboardingPages.elementAt(index).imageAssetPath,
                      height: 200,
                      fit: BoxFit.fitHeight,
                    ),
                    const SizedBox(height: 16), // Add spacing between image and title
                    Text(
                      onboardingPages.elementAt(index).title,
                      style: AppStyles.heading2.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 8), // Add spacing between title and description
                    Text(
                      onboardingPages.elementAt(index).description,
                      textAlign: TextAlign.center,
                      style: AppStyles.heading3.copyWith(
                        color: AppColors.textHintColor,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: 25.0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center, 
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, LoginPage.routeName);
                    },
                    child: Text(
                      "Skip",
                      style: AppStyles.heading3.copyWith(
                        color: AppColors.primaryColor, // Customize the skip button color
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboardingPages.length,
                      (index) => buildDot(index, context),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (currentIndex == onboardingPages.length - 1) {
                        // Navigate to home page or next screen
                        Navigator.pushReplacementNamed(context, LoginPage.routeName);
                      } else {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      }
                    },
                    child: Text(
                      "Next",
                      style: AppStyles.heading3.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 12 : 10,
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: currentIndex == index
            ? AppColors.primaryColor
            : AppColors.textHintColor,
      ),
    );
  }
}
