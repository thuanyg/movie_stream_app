import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_stream/configs/app_colors.dart';

class AppStyles {
  static TextStyle heading1 = GoogleFonts.lato(
    textStyle: const TextStyle(
      color: AppColors.textColor,
      fontSize: 24.0,
    ),
  );

  static TextStyle heading2 = GoogleFonts.lato(
    textStyle: const TextStyle(
      color: AppColors.textColor,
      fontSize: 28.0,
    ),
  );

  static TextStyle heading3 = GoogleFonts.lato(
    textStyle: const TextStyle(
      color: AppColors.textColor,
      fontSize: 16.0,
    ),
  );

  static TextStyle heading4 = GoogleFonts.lato(
    textStyle: const TextStyle(
      color: AppColors.textColor,
      fontSize: 14.0,
    ),
  );

  static TextStyle heading5 = GoogleFonts.lato(
    textStyle: const TextStyle(
      color: AppColors.textColor,
      fontSize: 12.0,
    ),
  );

  static TextStyle titleAppBar = GoogleFonts.lato(
    textStyle: const TextStyle(
      color: AppColors.textColor,
      fontSize: 20.0,
    ),
  );

  static TextStyle movieName = GoogleFonts.lato(
    textStyle: const TextStyle(
      color: AppColors.textColor,
      fontSize: 20.0,
      fontWeight: FontWeight.bold
    ),
  );
}
