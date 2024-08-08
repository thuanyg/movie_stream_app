import 'package:flutter/material.dart';
import 'package:movie_stream/configs/app_colors.dart';
import 'package:movie_stream/configs/app_styles.dart';
import 'package:movie_stream/models/slider.dart';
import 'package:movie_stream/ui/pages/detail/detail_page.dart';
import 'package:movie_stream/ui/pages/home/personal_screen.dart';
import 'package:movie_stream/ui/widgets/thumbnail_image.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> with AutomaticKeepAliveClientMixin{
  final List<SliderModel> thumbImages = [
    SliderModel(
        "https://phim.nguonc.com/public/images/Post/9/co-chau.jpg", "slink"),
    SliderModel(
        "https://phim.nguonc.com/public/images/Post/6/bi-mat-cua-chung-ta-phan-1.jpg",
        "slink"),
    SliderModel(
        "https://phim.nguonc.com/public/images/Post/3/ta-ninh-an.jpg", "slink"),
    SliderModel(
        "https://phim.nguonc.com/public/images/Post/8/bung-chay-nao-co-gai-bong-chuyen.jpg",
        "slink"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bottomNavColor,
        title: Text("Favorite movies", style: AppStyles.titleAppBar),
        centerTitle: true,
        leading: null,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
          itemCount: thumbImages.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: (){
                  goToDetailPage();
                },
                child: Container(
                  height: MediaQuery.of(context).size.height / 5,
                  // color: Colors.grey,
                  child: Row(
                    children: [
                      ThumbnailImage(thumbImages[index].imageLink.toString()),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          // Movie name
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Star Wars : The Last Jedi",
                              style: AppStyles.movieName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis
                            ),
                            Text("HD | Vietsub", style: AppStyles.heading4),
                            Text("Phim bộ | Hoạt hình",
                                style: AppStyles.heading4 ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  void goToDetailPage() {
    Navigator.pushNamed(context, DetailPage.routeName);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
