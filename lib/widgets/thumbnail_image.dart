import 'package:flutter/material.dart';
import 'package:movie_stream/helpers/image_helper.dart';

class ThumbnailImage extends StatelessWidget {

  final String imageLink;
  const ThumbnailImage(this.imageLink, {super.key});

  @override
  Widget build(BuildContext context) {
    return ImageHelper.loadNetworkImage(
        imageLink,
        radius: BorderRadius.circular(10),
        height: 160,
        width: 110,
        fit: BoxFit.cover);
  }
}
