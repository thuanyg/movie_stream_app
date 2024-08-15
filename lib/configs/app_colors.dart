import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppColors {
  static const Color backgroundColor = Color(0xFF18191E);
  static const Color primaryColor = Color(0xff867AD2);
  static const Color secondColor = Color(0xff6C61AF);
  static const Color textColor = Color(0xFFFFFFFF);
  static const Color textHintColor = Color(0xBBBBBBBB);
  static const Color bottomNavColor = Color(0x8E292929);
}

class AppGradient {
  static const defaultGradientBackground = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomLeft,
      colors: [AppColors.primaryColor, AppColors.secondColor]);
}
