import 'package:flutter/material.dart';

class ImageHelper {
  static Widget loadAssetImage(String imageAssetPath,
      {double? width,
      double? height,
      BorderRadius? radius,
      Color? tintColor,
      Alignment? alignment,
      BoxFit? fit}) {
    return ClipRRect(
      borderRadius: radius ?? BorderRadius.zero,
      child: Image.asset(imageAssetPath,
          width: width,
          height: height,
          fit: fit,
          color: tintColor,
          alignment: alignment ?? Alignment.center),
    );
  }

  static Widget loadNetworkImage(String imageLink,
      {double? width,
      double? height,
      BorderRadius? radius,
      Color? tintColor,
      Alignment? alignment,
      BoxFit? fit}) {
    return ClipRRect(
      borderRadius: radius ?? BorderRadius.zero,
      child: Image.network(imageLink,
          width: width,
          height: height,
          fit: fit,
          color: tintColor,
          alignment: alignment ?? Alignment.center),
    );
  }
}
