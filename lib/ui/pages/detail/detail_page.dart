import 'package:flutter/material.dart';
import 'package:movie_stream/configs/app_colors.dart';
import 'package:movie_stream/configs/app_styles.dart';
import 'package:movie_stream/dto/response/movies/detail_movie_response.dart';
import 'package:movie_stream/providers/movie/movie_provider.dart';
import 'package:movie_stream/ui/pages/detail/components/movie_play.dart';
import 'package:movie_stream/ui/pages/detail/components/movie_title.dart';
import 'package:movie_stream/ui/pages/stream/stream_page.dart';
import 'package:movie_stream/ui/widgets/progress_indicator.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  static const String routeName = '/DetailPage';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    String? slugMovie = ModalRoute.of(context)?.settings.arguments as String;
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xff15141F),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 16),
        child: FutureBuilder<MovieDetail>(
          future: movieProvider.getMovieDetail(slugMovie),
          builder: (BuildContext context, AsyncSnapshot<MovieDetail> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                height: size.height,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomCircularProgressIndicator(),
                      const SizedBox(height: 8.0),
                      Text(
                        "Đang tải...",
                        style: AppStyles.heading3,
                      ),
                    ],
                  ),
                ),
              );
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.hasData && snapshot.data != null) {
              final movieDetail = snapshot.data;
              return Column(
                children: [
                  MoviePlay(
                    thumbImg: movieDetail?.movie.thumbUrl,
                    onNavigate: (){
                      handleNavigateToStreamPage(context, movieDetail!);
                    },
                  ),
                  MovieTitle(
                    movieTitle: movieDetail?.movie.name ?? "Unknown",
                    quality: movieDetail?.movie.quality ?? "HD",
                  ),
                  TimeAndRate(
                    time: movieDetail?.movie.time ?? "Unknown",
                    rate: "7.0 (IMDb)",
                    episode: "${movieDetail!.movie.episodeTotal} Episode",
                  ),
                  const Divider(
                    height: 36,
                    endIndent: 24,
                    indent: 24,
                    thickness: .06,
                    color: Colors.grey,
                  ),
                  GenreAndDate(
                    releaseDate: '${movieDetail.movie.created.time.day}/'
                        '${movieDetail.movie.created.time.month}/'
                        '${movieDetail.movie.created.time.year}',
                    genres: movieDetail.movie.category
                        .take(2)
                        .map((item) => item.name)
                        .join(", "),
                  ),
                  const Divider(
                    height: 36,
                    endIndent: 24,
                    indent: 24,
                    thickness: .06,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Synopsis",
                          style: TextStyle(
                            fontFamily: 'Lato',
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          movieDetail.movie.content,
                          maxLines: 8,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.textHintColor,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Director",
                          style: TextStyle(
                            fontFamily: 'Lato',
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          movieDetail.movie.director
                              .map((item) => item)
                              .join(', '),
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                            color: AppColors.textHintColor,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Casts",
                          style: TextStyle(
                            fontFamily: 'Lato',
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          movieDetail.movie.actor
                              .map((actor) => actor)
                              .join(", "),
                          textAlign: TextAlign.justify,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.textHintColor,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Language",
                          style: TextStyle(
                            fontFamily: 'Lato',
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${movieDetail.movie.lang} (${movieDetail.movie.quality})',
                          textAlign: TextAlign.justify,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.textHintColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            }
            return Center(child: Text('Error: ${snapshot.error}'));
          },
        ),
      ),
    );
  }

  void handleNavigateToStreamPage(BuildContext context, MovieDetail movie) {
    Provider.of<MovieProvider>(context, listen: false).updateSelectedMovie(movie);
    Navigator.of(context).pushNamed(MovieStreamPage.routeName);
  }
}

class GenreAndDate extends StatelessWidget {
  final String releaseDate;
  final String genres;

  const GenreAndDate({
    required this.releaseDate,
    required this.genres,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Release date",
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              Text(
                releaseDate,
                style: const TextStyle(
                  color: AppColors.textHintColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Genre",
                  style: TextStyle(
                    fontFamily: 'Lato',
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Text(
                        genres,
                        style: const TextStyle(
                            color: AppColors.textHintColor,
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TimeAndRate extends StatelessWidget {
  final String time, rate, episode;

  const TimeAndRate({
    required this.time,
    required this.rate,
    required this.episode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          const Icon(Icons.access_time, size: 16, color: Colors.grey),
          const SizedBox(width: 3.0),
          Text(
            time,
            style: const TextStyle(
              color: AppColors.textHintColor,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 20.0),
          const Icon(Icons.star, size: 16, color: Colors.grey),
          const SizedBox(width: 3.0),
          Text(
            rate,
            style: const TextStyle(
              color: AppColors.textHintColor,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 20.0),
          const Icon(Icons.token_sharp, size: 16, color: Colors.grey),
          const SizedBox(width: 3.0),
          Text(
            episode,
            style: const TextStyle(
              color: AppColors.textHintColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
