import 'package:flutter/material.dart';
import 'package:movie_stream/configs/app_colors.dart';
import 'package:movie_stream/configs/app_strings.dart';
import 'package:movie_stream/configs/app_styles.dart';
import 'package:movie_stream/pages/home/home_page.dart';
import 'package:movie_stream/pages/login/components/login_form.dart';
import 'package:movie_stream/widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String routeName = '/LoginPage';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 150),
                child: Text("Log in to WatchEz", style: AppStyles.heading2)),

            LoginForm(
                usernameController: usernameController,
                passController: passwordController),

            const SizedBox(
              height: 20,
            ),

            const Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'OR',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16.0),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                side: BorderSide(color: Colors.grey.shade800),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                backgroundColor: Colors.black, // Button background color
              ),
              onPressed: () {
                // Handle Google sign in
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    'http://pngimg.com/uploads/google/google_PNG19635.png', // Path to Google icon
                    height: 24.0,
                  ),
                  SizedBox(width: 8.0),
                  const Text(
                    'Continue with Google',
                    style: TextStyle(color: Colors.white), // Text color
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                side: BorderSide(color: Colors.grey.shade800),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                backgroundColor: Colors.black, // Button background color
              ),
              onPressed: () {
                // Handle Facebook sign in
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.facebook,
                      color: Colors.blueAccent), // Facebook icon
                  SizedBox(width: 8.0),
                  Text(
                    'Continue with Facebook',
                    style: TextStyle(color: Colors.white), // Text color
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Privacy
            Text(
              AppStrings.loginPolicy,
              style:
                  AppStyles.heading5.copyWith(color: AppColors.textHintColor),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
