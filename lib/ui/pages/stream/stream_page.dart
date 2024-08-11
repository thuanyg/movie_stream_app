import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_stream/configs/app_colors.dart';
import 'package:movie_stream/configs/app_styles.dart';
import 'package:movie_stream/helpers/image_helper.dart';
import 'package:video_player/video_player.dart';

class MovieStreamPage extends StatefulWidget {
  static String routeName = "/MovieStreamPage";

  const MovieStreamPage({super.key});

  @override
  State<MovieStreamPage> createState() => _MovieStreamPageState();
}

class _MovieStreamPageState extends State<MovieStreamPage> {
  // late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    // controller = VideoPlayerController.networkUrl(
    //   Uri.parse("https://s1.phim1280.tv/20240110/oOY5watC/index.m3u8"), // Thay đổi liên kết m3u8 của bạn ở đây
    // )
    //   ..addListener(() => setState(() {}))
    //   ..setLooping(true)
    //   ..initialize().then((_) {
    //     setState(() {}); // Refresh UI
    //     controller.play();
    //   });
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                children: [
                  VideoPlayer(), // This will stay fixed
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const MainInfoMovie(),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
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
                            height: 50,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 16,
                                itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 6.0),
                                      decoration: BoxDecoration(
                                        color: AppColors.bottomNavColor,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: TextButton(onPressed: (){}, child: Text("Tập ${index + 1}", style: AppStyles.heading4)),
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
          ],
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
    return Container(
      color: AppColors.bottomNavColor,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text("The Spider Man 3",
                style: AppStyles.movieName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
          ),
          Row(
            children: [
              Icon(Icons.star, color: Colors.green, size: 18),
              Text("--", style: TextStyle(color: Colors.green)),
              Icon(Icons.arrow_right, color: Colors.green, size: 18),
              const SizedBox(
                height: 12, // Set the height of the VerticalDivider
                child: VerticalDivider(
                  color: Colors.grey,
                  thickness: 1, // Thickness of the divider
                ),
              ),
              Text("2024",
                  style: AppStyles.heading5.copyWith(color: Colors.white30)),
              const SizedBox(
                height: 12, // Set the height of the VerticalDivider
                child: VerticalDivider(
                  color: Colors.grey,
                  thickness: 1, // Thickness of the divider
                ),
              ),
              const SizedBox(
                height: 12, // Set the height of the VerticalDivider
                child: VerticalDivider(
                  color: Colors.grey,
                  thickness: 1, // Thickness of the divider
                ),
              ),
              Text("6/36 tập",
                  style: AppStyles.heading5.copyWith(color: Colors.white30)),
              const SizedBox(
                height: 12, // Set the height of the VerticalDivider
                child: VerticalDivider(
                  color: Colors.grey,
                  thickness: 1, // Thickness of the divider
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                decoration: BoxDecoration(
                    color: Color(0x4fa0a0a0),
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

class VideoPlayer extends StatelessWidget {
  const VideoPlayer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          Container(
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
