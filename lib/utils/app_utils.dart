import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:movie_stream/configs/app_colors.dart';
import 'package:movie_stream/configs/app_styles.dart';

class AppUtil {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.blueGrey,
      content: Text(
        message,
        style: AppStyles.heading4.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    ));
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

  static Future<void> showErrorDialog({
    required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onPressPositive,
    required VoidCallback onPressNegative,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      // Ngăn người dùng đóng dialog bằng cách chạm ra ngoài
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(onPressed: onPressPositive, child: const Text('Yes')),
            TextButton(onPressed: onPressNegative, child: const Text('No')),
          ],
        );
      },
    );
  }

  static void hideLoadingDialog(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }

  // SecureStorage
  static Future<void> writeSecureStorage(String key, String? value) async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.write(key: key, value: value);
  }

  static Future<String?> readSecureStorage(String key) async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    String? value = await storage.read(key: key);
    return value;
  }

  static Future<void> deleteSecureStorage(String key) async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.delete(key: key);
  }
}
