import 'package:flutter/material.dart';
import 'package:movie_stream/configs/app_styles.dart';

class MovieTitle extends StatelessWidget {
  final String movieTitle, quality;

  const MovieTitle({
    required this.movieTitle,
    required this.quality,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(movieTitle,
                    style: AppStyles.movieName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ),
              const SizedBox(width: 5.0),
              Container(
                height: 22,
                width: 29,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: Text(
                    quality,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
