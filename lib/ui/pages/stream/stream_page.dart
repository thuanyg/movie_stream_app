import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_stream/configs/app_colors.dart';
import 'package:movie_stream/configs/app_styles.dart';
import 'package:movie_stream/dto/response/movies/detail_movie_response.dart';
import 'package:movie_stream/providers/movie/movie_provider.dart';
import 'package:movie_stream/utils/app_utils.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../detail/detail_page.dart';

class MovieStreamPage extends StatefulWidget {
  static String routeName = "/MovieStreamPage";

  const MovieStreamPage({super.key});

  @override
  State<MovieStreamPage> createState() => _MovieStreamPageState();
}

class _MovieStreamPageState extends State<MovieStreamPage> {
  late FlickManager flickManager;

  late MovieProvider provider;
  MovieDetail? movie;

  @override
  void initState() {
    super.initState();

    provider = Provider.of<MovieProvider>(context, listen: false);

    movie = provider.getSelectedMovie!;

    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.networkUrl(
          Uri.parse(movie!.episodes.first.serverData.first.linkM3U8),
        ),
        autoInitialize: true,
        autoPlay: true,
        onVideoEnd: () {
          // Handle navigate to next episode.
        });
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  void _changeEpisode(String newUrl) {
    setState(() {
      VideoPlayerController videoPlayerController =
          VideoPlayerController.networkUrl(
        Uri.parse(newUrl),
      );

      flickManager.handleChangeVideo(videoPlayerController);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        var isFullScreen =
            MediaQuery.of(context).orientation == Orientation.landscape;
        if (isFullScreen) {
          flickManager.flickControlManager?.exitFullscreen();
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: FlickVideoPlayer(
                  flickManager: flickManager,
                  flickVideoWithControlsFullscreen:
                      const FlickVideoWithControls(
                    videoFit: BoxFit.scaleDown,
                    controls: FlickLandscapeControls(),
                  ),
                ),
              ),
              // This will stay fixed
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const MainInfoMovie(),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FunctionButton(
                                buttonName: "Yêu thích",
                                icon: Icons.favorite_border_sharp),
                            FunctionButton(
                                buttonName: "Chia sẻ", icon: Icons.share),
                            FunctionButton(
                                buttonName: "Thông tin",
                                icon: Icons.info_outlined),
                          ],
                        ),
                      ),
                      const Divider(
                          color: Colors.grey, thickness: .1, height: 0),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text("Episodes",
                              style: AppStyles.heading3
                                  .copyWith(fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Container(
                        height: size.height / 5,
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Wrap(
                            spacing: size.width / 16,
                            runSpacing: 6.0, // Khoảng cách dọc giữa các hàng
                            children: List.generate(
                              movie?.episodes[0].serverData.length ?? 0,
                              // Số lượng tập phim
                              (index) {
                                return Consumer<MovieProvider>(
                                  builder: (BuildContext context,
                                      MovieProvider mProvider, Widget? child) {
                                    return Container(
                                      width: 70, // Chiều rộng của mỗi button
                                      decoration: BoxDecoration(
                                        color: mProvider.getCurrentEpisode ==
                                                index + 1
                                            ? Colors.blueGrey.shade400
                                            : AppColors.bottomNavColor,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          mProvider
                                              .setCurrentEpisode(index + 1);
                                          _changeEpisode(movie!.episodes[0]
                                              .serverData[index].linkM3U8);
                                        },
                                        child: Text(
                                            movie?.episodes[0].serverData
                                                        .length ==
                                                    1
                                                ? "Full"
                                                : "Tập ${index + 1}",
                                            style: AppStyles.heading4),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        height: 36,
                        thickness: .06,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 8.0),
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
                              movie!.movie.content,
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
                              movie!.movie.director
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
                              movie!.movie.actor
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
                              '${movie?.movie.lang} (${movie?.movie.quality})',
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
                      ),
                      const SizedBox(height: 10),
                      GenreAndDate(
                        releaseDate: '${movie?.movie.created.time.day}/'
                            '${movie?.movie.created.time.month}/'
                            '${movie?.movie.created.time.year}',
                        genres: movie!.movie.category
                            .take(2)
                            .map((item) => item.name)
                            .join(", "),
                      ),
                      const SizedBox(height: 400),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FunctionButton extends StatelessWidget {
  final String buttonName;
  final IconData icon;

  const FunctionButton({
    required this.buttonName,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Icon(icon, color: Colors.grey, size: 22),
          const SizedBox(height: 8.0),
          Text(buttonName,
              style: AppStyles.heading4.copyWith(color: Colors.grey))
        ],
      ),
    );
  }
}

class MainInfoMovie extends StatelessWidget {
  const MainInfoMovie({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    MovieProvider provider = Provider.of<MovieProvider>(context);

    MovieDetail movie = provider.getSelectedMovie!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(movie.movie.name,
                      style: AppStyles.movieName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
              Container(
                height: 22,
                width: 29,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: Text(
                    movie.movie.quality,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.green, size: 18),
              const Text("--", style: TextStyle(color: Colors.green)),
              const Icon(Icons.arrow_right, color: Colors.green, size: 18),
              const SizedBox(
                height: 12, // Set the height of the VerticalDivider
                child: VerticalDivider(
                  color: Colors.grey,
                  thickness: 1, // Thickness of the divider
                ),
              ),
              Text(movie.movie.year.toString(),
                  style: AppStyles.heading5.copyWith(color: Colors.white30)),
              const SizedBox(
                height: 12, // Set the height of the VerticalDivider
                child: VerticalDivider(
                  color: Colors.grey,
                  thickness: 1, // Thickness of the divider
                ),
              ),
              Text('${movie.movie.episodeTotal} tập',
                  style: AppStyles.heading5.copyWith(color: Colors.white30)),
              const SizedBox(
                height: 12, // Set the height of the VerticalDivider
                child: VerticalDivider(
                  color: Colors.grey,
                  thickness: 1, // Thickness of the divider
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    color: const Color(0x4fa0a0a0),
                    borderRadius: BorderRadius.circular(4)),
                child: Text("Phụ đề",
                    style: AppStyles.heading5.copyWith(color: Colors.white30)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
