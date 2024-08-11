import 'package:flutter/material.dart';
import 'package:movie_stream/configs/app_colors.dart';
import 'package:movie_stream/configs/app_strings.dart';
import 'package:movie_stream/configs/app_styles.dart';

class AppUtil {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  static void showLoadingDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      // Ngăn người dùng đóng dialog bằng cách nhấn ra ngoài
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          // Ngăn người dùng đóng dialog bằng nút back
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  color: AppColors.primaryColor,
                  backgroundColor: AppColors.secondColor,
                ),
                const SizedBox(height: 12),
                Text(
                  message,
                  style: AppStyles.heading3.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}
