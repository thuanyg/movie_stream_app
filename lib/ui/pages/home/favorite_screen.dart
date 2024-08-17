import 'package:flutter/material.dart';
import 'package:movie_stream/configs/app_colors.dart';
import 'package:movie_stream/configs/app_styles.dart';
import 'package:movie_stream/dto/response/users/favorite_response.dart';
import 'package:movie_stream/providers/user/favorite_provider.dart';
import 'package:movie_stream/ui/pages/detail/detail_page.dart';
import 'package:movie_stream/ui/widgets/progress_indicator.dart';
import 'package:movie_stream/ui/widgets/thumbnail_image.dart';
import 'package:movie_stream/utils/app_utils.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>
    with AutomaticKeepAliveClientMixin {
  late FavoriteProvider favoriteProvider;

  @override
  void initState() {
    super.initState();
    favoriteProvider = Provider.of<FavoriteProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bottomNavColor,
        title: Text("Favorite movies", style: AppStyles.titleAppBar),
        centerTitle: true,
        leading: null,
        automaticallyImplyLeading: false,
      ),
      body: Consumer<FavoriteProvider>(
        builder: (context, provider, child) {
          final listFavorite = provider.getListFavoriteMovie;
          if (listFavorite.isEmpty) {
            return Center(
              child: Text(
                "Chưa có phim nào được lưu.",
                style: AppStyles.heading3,
              ),
            );
          } else {
            return ListView.builder(
                itemCount: listFavorite.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        goToDetailPage(listFavorite[index].slug!);
                      },
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 5,
                        // color: Colors.grey,
                        child: Row(
                          children: [
                            ThumbnailImage(listFavorite[index].posterUrl!),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                // Movie name
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    listFavorite[index].name!,
                                    style: AppStyles.movieName,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "${listFavorite[index].quality!} | ${listFavorite[index].language!}",
                                    style: AppStyles.heading5,
                                  ),
                                  Text(
                                    listFavorite[index].genres!,
                                    style: AppStyles.heading5,
                                  ),
                                  Text(
                                    "Đã lưu 3 ngày trước",
                                    style: AppStyles.heading5.copyWith(
                                        color: AppColors.primaryColor),
                                  ),
                                  Center(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 38,
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pushNamed(
                                                  DetailPage.routeName,
                                                  arguments: "",
                                                );
                                              },
                                              style: const ButtonStyle(
                                                elevation:
                                                    WidgetStatePropertyAll(4),
                                                backgroundColor:
                                                    WidgetStatePropertyAll(
                                                        Colors.green),
                                              ),
                                              child: Text(
                                                "Xem ngay",
                                                style: AppStyles.heading4
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 38,
                                          margin: const EdgeInsets.only(
                                              top: 10, left: 8),
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              AppUtil.showLoadingDialog(
                                                context,
                                                "Đang xóa...",
                                              );
                                              await favoriteProvider
                                                  .deleteFavoriteMovies(
                                                      listFavorite[index]
                                                          .favoriteMovieId!);
                                              AppUtil.hideLoadingDialog(
                                                  context);
                                            },
                                            style: ButtonStyle(
                                              elevation:
                                                  const WidgetStatePropertyAll(
                                                      4),
                                              backgroundColor:
                                                  WidgetStatePropertyAll(
                                                      Colors.red.shade500),
                                            ),
                                            child: Text(
                                              "Xóa",
                                              style: AppStyles.heading4
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }

  void goToDetailPage(String slug) {
    Navigator.pushNamed(context, DetailPage.routeName, arguments: slug);
  }

  @override
  bool get wantKeepAlive => true;
}
