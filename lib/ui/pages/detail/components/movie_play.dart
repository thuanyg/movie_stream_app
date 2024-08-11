import 'package:flutter/material.dart';
import 'package:movie_stream/helpers/image_helper.dart';

class MoviePlay extends StatelessWidget {
  const MoviePlay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: InkWell(
        onTap: (){},
        child: Stack(
          fit: StackFit.expand,
          children: [
            Opacity(
              opacity: .8,
              child: ImageHelper.loadNetworkImage(
                "https://phim.nguonc.com/public/images/Post/3/ta-ninh-an-1.jpg",
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
