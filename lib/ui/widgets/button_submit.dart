import 'package:flutter/material.dart';
import 'package:movie_stream/configs/app_colors.dart';
import 'package:movie_stream/configs/app_styles.dart';

class SubmitButton extends StatelessWidget {
  final String textButton;
  final GlobalKey<FormState>? formKey;
  VoidCallback onClick;

  SubmitButton(
      {super.key,
        required this.textButton,
        this.formKey,
        required this.onClick});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        onTap: onClick,
        child: Ink(
          width: size.width,
          height: 50,
          decoration: BoxDecoration(
              gradient: AppGradient.defaultGradientBackground,
              borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Text(
              textButton,
              style: AppStyles.heading3
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
