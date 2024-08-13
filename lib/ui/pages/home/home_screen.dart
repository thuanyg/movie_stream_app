import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_stream/configs/app_colors.dart';
import 'package:movie_stream/configs/app_styles.dart';
import 'package:movie_stream/configs/constants.dart';
import 'package:movie_stream/dto/response/movie_by_genre/api_response.dart';
import 'package:movie_stream/dto/response/movie_by_genre/items.dart';
import 'package:movie_stream/dto/response/movies/movie.dart';
import 'package:movie_stream/helpers/image_helper.dart';
import 'package:movie_stream/models/items_latest_movie.dart';
import 'package:movie_stream/providers/movie/movie_provider.dart';
import 'package:movie_stream/ui/pages/detail/detail_page.dart';
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

  final Map<String, String> categories = {
    PHIM_HOAT_HINH: "Hoạt hình",
    PHIM_BO: "Phim bộ",
    TV_SHOWS: "TV Shows",
  };

  late Future<List<ItemsLatestMovie>?> _latestMoviesFuture;
  late Future<List<Item>?> _moviesByGenreFuture;
  late Future<List<Item>?> _oddMoviesFuture;

  late MovieProvider provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<MovieProvider>(context, listen: false);

    _latestMoviesFuture = provider.getListLatestMovie(1);
    _oddMoviesFuture = provider.getMoviesByGenre(PHIM_LE, 1);

    // Movie by each tab
    _moviesByGenreFuture = provider.getMoviesByGenre(categories.keys.first, 1);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
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
                    height: 160,
                    aspectRatio: 16/9,
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
                    SizedBox(
                      height: size.height / 3.2,
                      child: FutureBuilder<List<ItemsLatestMovie>?>(
                        future: _latestMoviesFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CustomCircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text(
                                    'Đã xảy ra lỗi. Làm mới để thử lại.',
                                    style: AppStyles.heading4));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text('Không có phim nào'));
                          } else {
                            final latestMovies = snapshot.data!;
                            return ListView.builder(
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
                                          // Handle navigate to detail movie (agr = slug)
                                          Navigator.of(context).pushNamed(
                                            DetailPage.routeName,
                                            arguments: latestMovies[index].slug,
                                          );
                                        },
                                        child: ThumbnailImage(
                                          latestMovies[index].posterUrl ?? '',
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        latestMovies[index].name ?? 'No name',
                                        style: AppStyles.heading4,
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
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
                      child: FutureBuilder(
                          future: _oddMoviesFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CustomCircularProgressIndicator(),
                              );
                            }
                            if (snapshot.hasData) {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: size.width * 0.3,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        handleNavigateToDetailPage(
                                          context: context,
                                          routeName: DetailPage.routeName,
                                          data: snapshot.data![index].slug,
                                        );
                                      },
                                      child: Column(children: [
                                        ImageHelper.loadNetworkImage(
                                            "https://phimimg.com/${snapshot.data![index].posterUrl}",
                                            radius: BorderRadius.circular(10),
                                            height: 180,
                                            width: 150,
                                            fit: BoxFit.fitHeight),
                                        Text(
                                          snapshot.data?[index].name ?? "",
                                          style: AppStyles.heading3,
                                        )
                                      ]),
                                    ),
                                  );
                                },
                              );
                            }
                            return Center(
                                child: Text(
                                    'Đã xảy ra lỗi. Làm mới để thử lại.',
                                    style: AppStyles.heading4));
                          }),
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
                                child: Text(
                                  categories.values.elementAt(index),
                                  style: AppStyles.heading4,
                                ),
                                onPressed: () async {
                                  setState(() {
                                    currentTabSelectedIndex = index;
                                    _moviesByGenreFuture =
                                        provider.getMoviesByGenre(
                                      categories.keys.elementAt(index),
                                      1,
                                    );
                                  });
                                },
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
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 1,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return FutureBuilder(
                  future: _moviesByGenreFuture,
                  // Replace this with your future
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CustomCircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      final data = snapshot.data;
                      return GestureDetector(
                        onTap: () {
                          handleNavigateToDetailPage(
                            context: context,
                            routeName: DetailPage.routeName,
                            data: snapshot.data![index].slug,
                          );
                        },
                        child: Stack(
                          children: [
                            Opacity(
                              opacity: .6,
                              child: Center(
                                child: ImageHelper.loadNetworkImage(
                                    "https://phimimg.com/${data![index].posterUrl}",
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
                                    bottom: 2.0, left: 28, right: 28),
                                child: Text(
                                  data[index].name.toString(),
                                  style: AppStyles.heading3.copyWith(
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Center(child: Text('No data available'));
                    }
                  },
                );
              },
              childCount: 10, // Number of items in the grid
            ),
          ),
        ],
      ),
    ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void handleNavigateToDetailPage(
      {required BuildContext context,
      required String routeName,
      required String? data}) {
    // Handle navigate to detail movie (agr = slug)
    Navigator.of(context).pushNamed(
      routeName,
      arguments: data,
    );
  }
}
