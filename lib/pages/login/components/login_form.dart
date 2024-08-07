import 'package:flutter/material.dart';
import 'package:movie_stream/configs/app_colors.dart';
import 'package:movie_stream/configs/app_styles.dart';
import 'package:movie_stream/pages/home/home_page.dart';
import 'package:movie_stream/widgets/text_field.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passController;

   const LoginForm({
    Key? key,
    required this.usernameController,
    required this.passController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(children: [
      // Username Textfield
      CustomTextField(
          controller: usernameController,
          label: "Username",
          isPassword: false,
          prefixIcon: Icons.person),
      const SizedBox(height: 20),

      // Password Textfield
      CustomTextField(
          controller: passController,
          label: "Password",
          isPassword: true,
          prefixIcon: Icons.lock),

      // Forgot password + button Login
      Container(
        alignment: Alignment.topLeft,
        child: TextButton(
            onPressed: () {},
            child: Text(
              "Forgot password?",
              style: AppStyles.heading3.copyWith(color: Colors.green),
            )),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: InkWell(
          onTap: () {
            // Task Login here
            Navigator.pushNamed(context, HomePage.routeName);
          },
          child: Ink(
            width: size.width,
            height: 50,
            decoration: BoxDecoration(
                gradient: AppGradient.defaultGradientBackground,
                borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Text(
                "Login",
                style: AppStyles.heading3
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
