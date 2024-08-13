import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:movie_stream/configs/app_colors.dart';
import 'package:movie_stream/configs/app_styles.dart';
import 'package:movie_stream/dto/response/movies/detail_movie_response.dart';
import 'package:movie_stream/providers/movie/movie_provider.dart';
import 'package:movie_stream/utils/app_utils.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

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

    MovieProvider provider = Provider.of<MovieProvider>(context, listen: false);

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
    var isFullScreen =
        MediaQuery.of(context).orientation == Orientation.landscape;

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
                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: movie?.episodes[0].serverData.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 6.0),
                                decoration: BoxDecoration(
                                  color: AppColors.bottomNavColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: TextButton(
                                    onPressed: () {
                                      _changeEpisode(movie!.episodes[0]
                                          .serverData[index].linkM3U8);
                                    },
                                    child: Text("Tập ${index + 1}",
                                        style: AppStyles.heading4)),
                              );
                            }),
                      )
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
      color: AppColors.bottomNavColor,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(movie.movie.name,
                style: AppStyles.movieName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
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
              Text(movie.movie.episodeCurrent,
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
