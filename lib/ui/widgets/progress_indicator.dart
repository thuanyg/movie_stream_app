import 'package:flutter/material.dart';
import 'package:movie_stream/configs/app_colors.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: AppColors.primaryColor,
      backgroundColor: AppColors.secondColor,
    );
  }
}
