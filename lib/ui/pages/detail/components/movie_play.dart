import 'package:flutter/material.dart';
import 'package:movie_stream/helpers/image_helper.dart';


class MoviePlay extends StatelessWidget {
  String? thumbImg;
  VoidCallback onNavigate;
  MoviePlay({
    super.key,
    required this.thumbImg,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: InkWell(
        onTap: onNavigate,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Opacity(
              opacity: .8,
              child: ImageHelper.loadNetworkImage(
                thumbImg ?? "",
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            Center(
              child: ImageHelper.loadAssetImage("assets/images/ic_play.png", height: 48),
            ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 100, // Chiều cao của gradient
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
