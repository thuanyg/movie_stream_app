import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_stream/configs/app_colors.dart';

class CustomLoadingProgress extends StatelessWidget {
  const CustomLoadingProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Lottie.asset(
          height: 64,
          "assets/animation/loading_animation.json",
          fit: BoxFit.cover,
        ),
    );
  }
}
