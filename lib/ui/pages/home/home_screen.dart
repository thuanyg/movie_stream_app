import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_stream/configs/app_colors.dart';
import 'package:movie_stream/configs/app_styles.dart';
import 'package:movie_stream/helpers/image_helper.dart';
import 'package:movie_stream/models/items_latest_movie.dart';
import 'package:movie_stream/providers/movie/movie_provider.dart';
import 'package:movie_stream/ui/pages/home/components/category_label.dart';
import 'package:movie_stream/ui/pages/home/components/search_bar.dart';
import 'package:movie_stream/models/slider.dart';
import 'package:movie_stream/ui/widgets/progress_indicator.dart';
import 'package:movie_stream/ui/widgets/thumbnail_image.dart';
import 'package:movie_stream/utils/app_utils.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  int _current = 0;
  int currentTabSelectedIndex = 0;
  final TextEditingController searchController = TextEditingController();
  final scrollController = ScrollController();
  final List<SliderModel> sliders = [
    SliderModel(
        "https://phim.nguonc.com/public/images/Post/9/co-chau-1.jpg", "slink"),
    SliderModel(
        "https://phim.nguonc.com/public/images/Post/6/bi-mat-cua-chung-ta-phan-1-1.jpg",
        "slink"),
    SliderModel("https://phim.nguonc.com/public/images/Post/3/ta-ninh-an-1.jpg",
        "slink"),
    SliderModel(
        "https://phim.nguonc.com/public/images/Post/8/bung-chay-nao-co-gai-bong-chuyen-1.jpg",
        "slink"),
  ];
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
  final List<String> categories = [
    "Phim bộ",
    "Phim đang chiếu",
    "Hàn Quốc",
    "Trung Quốc",
    "Việt Nam"
  ];

  late Future<List<ItemsLatestMovie>?> _latestMoviesFuture;
  late MovieProvider provider;

  @override
  void initState() {
    super.initState();

    provider = Provider.of<MovieProvider>(context, listen: false);

    _latestMoviesFuture = provider.getListLatestMovie(1);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                CustomSearchBar(searchController: searchController),
                const SizedBox(height: 16),
                // Slider
                CarouselSlider(
                  options: CarouselOptions(
                    height: 180,
                    aspectRatio: 0.7,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 1000),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                  ),
                  items: sliders.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 3.0),
                            child: ImageHelper.loadNetworkImage(
                                i.imageLink.toString(),
                                radius: BorderRadius.circular(10),
                                fit: BoxFit.fill));
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 8),
                // Movies by categories
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(children: [
                    // Latest movies
                    Category(
                      categoryName: "Mới cập nhật",
                      onSeeAll: () {
                        print("See allllllllllll");
                      },
                    ),
                    provider.isLoading
                        ? const Center(child: CustomCircularProgressIndicator())
                        : FutureBuilder<List<ItemsLatestMovie>?>(
                            future: _latestMoviesFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CustomCircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return const Center(
                                    child: Text('Đã xảy ra lỗi'));
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return const Center(
                                    child: Text('Không có phim nào'));
                              } else {
                                final latestMovies = snapshot.data!;
                                return SizedBox(
                                  height: size.height / 3.2,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: latestMovies.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: size.width * 0.3,
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 8.0,
                                        ),
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                AppUtil.showSnackBar(context,
                                                    'Movies ID: ${latestMovies[index].sId}');
                                              },
                                              child: ThumbnailImage(
                                                latestMovies[index].posterUrl ??
                                                    '',
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              latestMovies[index].name ??
                                                  'No name',
                                              style: AppStyles.heading4,
                                              textAlign: TextAlign.center,
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                          ),

                    // Odd films
                    Category(
                      categoryName: "Phim lẻ",
                      onSeeAll: () {
                        print("See allllllllllll");
                      },
                    ),
                    SizedBox(
                      height: size.height / 3,
                      child: ListView.builder(
                        shrinkWrap: true,
                        // Hỗ trợ việc xây dựng ListView bên trong Column
                        itemCount: thumbImages.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            width: size.width * 0.3,
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(children: [
                              ImageHelper.loadNetworkImage(
                                  thumbImages[index].imageLink.toString(),
                                  radius: BorderRadius.circular(10),
                                  height: 180,
                                  width: 150,
                                  fit: BoxFit.fitHeight),
                              Text(
                                "Phim le",
                                style: AppStyles.heading3,
                              )
                            ]),
                          );
                        },
                      ),
                    ),

                    // Tab Categories
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 3.0),
                              decoration: BoxDecoration(
                                  color: currentTabSelectedIndex == index
                                      ? AppColors.secondColor
                                      : AppColors.bottomNavColor,
                                  borderRadius: BorderRadius.circular(20)),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    currentTabSelectedIndex = index;
                                  });
                                },
                                child: Text(categories[index],
                                    style: AppStyles.heading4),
                              ),
                            );
                          }),
                    ),

                    const SizedBox(height: 16)
                  ]),
                ),
              ],
            ),
          ),
          // TabView
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 1,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              return Stack(
                children: [
                  Opacity(
                    opacity: .6,
                    child: Center(
                      child: ImageHelper.loadNetworkImage(
                          thumbImages[3].imageLink.toString(),
                          radius: BorderRadius.circular(10),
                          height: 200,
                          width: 150,
                          fit: BoxFit.cover),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(
                          bottom: 8.0, left: 28, right: 28),
                      child: Text(
                        categories[currentTabSelectedIndex],
                        style: AppStyles.heading3
                            .copyWith(color: AppColors.textColor),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              );
            }, childCount: 10),
          )
        ],
      ),
    ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
