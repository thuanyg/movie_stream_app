import 'package:flutter/material.dart';
import 'package:movie_stream/configs/app_colors.dart';
import 'package:movie_stream/configs/app_styles.dart';
import 'package:movie_stream/modules/validator.dart';
import 'package:movie_stream/ui/pages/home/home_page.dart';
import 'package:movie_stream/ui/pages/signup_page.dart';
import 'package:movie_stream/ui/widgets/button_submit.dart';
import 'package:movie_stream/ui/widgets/text_field.dart';
import 'package:movie_stream/utils/app_utils.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController passController;

  LoginForm({
    Key? key,
    required this.usernameController,
    required this.passController,
  }) : super(key: key);

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
    final Size size = MediaQuery.of(context).size;

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
            onClick: () async {
              await LoginAction(context);
            }),
      ]),
    );
  }

  Future<void> LoginAction(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      String username = widget.usernameController.text.trim();
      String password = widget.passController.text.trim();

      AppUtil.showLoadingDialog(
          context, "Please hold on, we are logging you in...");

      try {
        // Giả lập quá trình đăng nhập
        await Future.delayed(Duration(seconds: 2));

        // TODO: Thực hiện quá trình đăng nhập ở đây

        Navigator.of(context).pop(); // Đóng hộp thoại tải
        Navigator.pushReplacementNamed(context, HomePage.routeName);
      } catch (e) {
        Navigator.of(context).pop(); // Đóng hộp thoại tải
        // Xử lý lỗi nếu có
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $e')),
        );
      }
    }
  }
}
