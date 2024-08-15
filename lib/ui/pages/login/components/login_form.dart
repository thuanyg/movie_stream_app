import 'package:flutter/material.dart';
import 'package:movie_stream/configs/app_colors.dart';
import 'package:movie_stream/configs/app_styles.dart';
import 'package:movie_stream/dto/request/auth_request.dart';
import 'package:movie_stream/modules/validator.dart';
import 'package:movie_stream/providers/auth/login_provider.dart';
import 'package:movie_stream/ui/pages/home/home_page.dart';
import 'package:movie_stream/ui/pages/signup/signup_page.dart';
import 'package:movie_stream/ui/widgets/button_submit.dart';
import 'package:movie_stream/ui/widgets/text_field.dart';
import 'package:movie_stream/utils/app_utils.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController passController;

  const LoginForm({
    super.key,
    required this.usernameController,
    required this.passController,
  });

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final String usernameSignUp =
          ModalRoute.of(context)?.settings.arguments as String? ?? "";
      if (usernameSignUp.isNotEmpty) {
        widget.usernameController.text = usernameSignUp;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        // Username Textfield
        CustomTextField(
          controller: widget.usernameController,
          label: "Username",
          prefixIcon: Icons.person,
          validator: Validator.validateUsername,
        ),
        const SizedBox(height: 20),

        // Password Textfield
        CustomTextField(
          controller: widget.passController,
          label: "Password",
          passwordType: true,
          prefixIcon: Icons.lock,
          validator: Validator.validatePassword,
        ),

        // Forgot password + button Login
        Row(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                "Don't have an account?",
                style: AppStyles.heading4.copyWith(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, SignupPage.routeName);
              },
              child: Text(
                "Sign up",
                style:
                    AppStyles.heading4.copyWith(color: AppColors.primaryColor),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topRight,
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot?",
                      style: AppStyles.heading4
                          .copyWith(color: AppColors.primaryColor),
                    )),
              ),
            ),
          ],
        ),

        SubmitButton(
          formKey: _formKey,
          textButton: "Login",
          onClick: loginAction,
        ),
      ]),
    );
  }

  Future<void> loginAction() async {
    if (_formKey.currentState?.validate() ?? false) {
      String username = widget.usernameController.text.trim();
      String password = widget.passController.text.trim();

      AuthRequest authRequest = AuthRequest(username, username, password);

      final loginProvider = Provider.of<LoginProvider>(context, listen: false);

      AppUtil.showLoadingDialog(context, "We are logging you in...");

      try {
        bool isLoginSuccess =
            await loginProvider.loginAuthenticate(context, authRequest);
        AppUtil.hideLoadingDialog(context);
        if (isLoginSuccess && context.mounted) {
          Navigator.of(context).pushReplacementNamed(HomePage.routeName);
        }
      } finally {
        AppUtil.hideLoadingDialog(context);
      }
    }
  }
}
