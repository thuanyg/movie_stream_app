import 'package:flutter/material.dart';
import 'package:movie_stream/configs/app_colors.dart';
import 'package:movie_stream/configs/app_styles.dart';
import 'package:movie_stream/helpers/image_helper.dart';
import 'package:movie_stream/modules/signup/signup_controller.dart';
import 'package:movie_stream/modules/validator.dart';
import 'package:movie_stream/repository/user_repository.dart';
import 'package:movie_stream/ui/pages/login/login_page.dart';
import 'package:movie_stream/ui/widgets/button_submit.dart';
import 'package:movie_stream/ui/widgets/text_field.dart';
import 'package:movie_stream/utils/app_utils.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  static const String routeName = "/SignupPage";

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String gender = "Male";
  late SignUpController _signUpController;
  final signup_formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _signUpController = SignUpController(context, UserRepository());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Form(
                key: signup_formKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 24.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Sign Up",
                        style: AppStyles.heading1
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: ImageHelper.loadAssetImage(
                          "assets/images/ic_launcher.png",
                          height: 100,
                          width: 100),
                    ),
                    CustomTextField(
                      controller: _emailController,
                      label: "Email",
                      prefixIcon: Icons.email_outlined,
                      textInputType: TextInputType.emailAddress,
                      validator: Validator.validateEmail,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: _usernameController,
                      label: "Username",
                      prefixIcon: Icons.person_outline,
                      textInputType: TextInputType.text,
                      validator: Validator.validateUsername,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: _passwordController,
                      label: "Password",
                      passwordType: true,
                      prefixIcon: Icons.lock_outline,
                      textInputType: TextInputType.text,
                      validator: Validator.validatePassword,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: _rePasswordController,
                      label: "Confirm password",
                      passwordType: true,
                      prefixIcon: Icons.lock_outline,
                      textInputType: TextInputType.text,
                      validator: (value) {
                        return Validator.validateConfirmPassword(
                            value, _passwordController);
                      },
                    ),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Already have an account?",
                            style:
                                AppStyles.heading4.copyWith(color: Colors.grey),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, LoginPage.routeName);
                          },
                          child: Text(
                            "Login",
                            style: AppStyles.heading4
                                .copyWith(color: AppColors.primaryColor),
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
                    const SizedBox(height: 16),
                    SubmitButton(
                      textButton: "Sign Up",
                      onClick: () async {
                        if (signup_formKey.currentState?.validate() ?? false) {
                          String username = _usernameController.text.trim();
                          String email = _emailController.text.trim();
                          String password = _passwordController.text.trim();

                          // Hiển thị loading dialog
                          AppUtil.showLoadingDialog(
                              context, "Creating your account...");

                          _signUpController
                              .signUp(username, email, password)
                              .then((success) {
                            AppUtil.hideLoadingDialog(context);
                            if (success) {
                              Navigator.of(context).pushReplacementNamed(
                                  LoginPage.routeName,
                                  arguments: username);
                            } else {
                              // Hiển thị lỗi hoặc xử lý khác
                            }
                          });
                        }
                      },
                    )

                    // Row(
                    //   children: [
                    //     Text("Male", style: AppStyles.heading3),
                    //     Radio(
                    //       value: "Male",
                    //       groupValue: gender,
                    //       activeColor: Colors.blueGrey,
                    //       onChanged: (value) {
                    //         setState(() {
                    //           gender = value!;
                    //         });
                    //       },
                    //     ),
                    //     Text("Male", style: AppStyles.heading3),
                    //     Radio(
                    //       value: "Female",
                    //       groupValue: gender,
                    //       activeColor: Colors.blueGrey,
                    //       onChanged: (value) {
                    //         setState(() {
                    //           gender = value!;
                    //         });
                    //       },
                    //     ),
                    //     Text("Female", style: AppStyles.heading3),
                    //   ],
                    // )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
