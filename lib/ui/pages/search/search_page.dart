import 'package:flutter/material.dart';
import 'package:movie_stream/configs/app_colors.dart';
import 'package:movie_stream/configs/app_styles.dart';
import 'package:movie_stream/configs/constants.dart';
import 'package:movie_stream/helpers/image_helper.dart';
import 'package:movie_stream/providers/movie/movie_provider.dart';
import 'package:movie_stream/ui/pages/detail/detail_page.dart';
import 'package:movie_stream/ui/widgets/progress_indicator.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  static const String routeName = "/SearchPage";

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _textEditingController = TextEditingController();
  late ScrollController _scrollController;
  late MovieProvider provider;
  late String keyword;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    provider = Provider.of<MovieProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      keyword = ModalRoute.of(context)?.settings.arguments as String;
      _textEditingController.text = keyword;
      handleSearchMovie(keyword);
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      provider.loadMoreMovies(_textEditingController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF18191E),
      appBar: AppBar(
        backgroundColor: const Color(0x8E292929),
        elevation: 2.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white70,
            size: 20,
          ),
        ),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0x8E464646),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(
                  Icons.search_rounded,
                  color: Colors.white54,
                  size: 18,
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 3.0),
                  child: TextField(
                    controller: _textEditingController,
                    cursorColor: AppColors.primaryColor,
                    style: AppStyles.heading3.copyWith(color: Colors.white54),
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                    ),
                    onSubmitted: (value) {
                      handleSearchMovie(value);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: Consumer<MovieProvider>(
        builder: (context, provider, child) {
          final movies = provider.getListMovieResult; // List of search result

          if (movies.isEmpty && provider.isLoading) {
            return const Center(child: CustomLoadingProgress());
          }

          return ListView.builder(
              controller: _scrollController,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                if (index < movies.length) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 16),
                    child: Column(
                      children: [
                        // Genre
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            movies[index].type!,
                            style: AppStyles.heading5
                                .copyWith(color: Colors.white60),
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ImageHelper.loadNetworkImage(
                                "https://phimimg.com/${movies[index].posterUrl}",
                                height: 165,
                                width: 120,
                                fit: BoxFit.fill,
                                radius: BorderRadius.circular(4)),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(movies[index].name.toString(),
                                        maxLines: 2, style: AppStyles.heading4),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.star,
                                          color: Colors.green, size: 16),
                                      const SizedBox(width: 2),
                                      Text("9.7",
                                          style: AppStyles.heading5
                                              .copyWith(color: Colors.green))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(movies[index].year.toString(),
                                          style: AppStyles.heading5.copyWith(
                                              color: AppColors.textHintColor)),
                                      const SizedBox(
                                        height: 10,
                                        child: VerticalDivider(
                                          color: Colors.grey,
                                          thickness: 1,
                                        ),
                                      ),
                                      Text(movies[index].country[0].name!,
                                          style: AppStyles.heading5.copyWith(
                                              color: AppColors.textHintColor)),
                                      const SizedBox(
                                        height: 10,
                                        child: VerticalDivider(
                                          color: Colors.grey,
                                          thickness: 1,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text("Lãng mạn",
                                            style: AppStyles.heading5.copyWith(
                                                color: AppColors.textHintColor,
                                                overflow:
                                                    TextOverflow.ellipsis)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Quality: ",
                                          style: AppStyles.heading5.copyWith(
                                              color: AppColors.textHintColor,
                                              fontWeight: FontWeight.bold)),
                                      Text("FHD",
                                          style: AppStyles.heading5.copyWith(
                                              color: AppColors.textHintColor)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Lang: ",
                                          style: AppStyles.heading5.copyWith(
                                              color: AppColors.textHintColor,
                                              fontWeight: FontWeight.bold)),
                                      Text("Vietsub",
                                          style: AppStyles.heading5.copyWith(
                                              color: AppColors.textHintColor)),
                                    ],
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                        DetailPage.routeName,
                                        arguments: movies[index].slug,
                                      );
                                    },
                                    style: const ButtonStyle(
                                      elevation: WidgetStatePropertyAll(4),
                                      backgroundColor:
                                          WidgetStatePropertyAll(Colors.green),
                                    ),
                                    child: Text(
                                      "Xem ngay",
                                      style: AppStyles.heading4.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                } else {
                  return provider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : const SizedBox
                          .shrink(); // Trả về widget rỗng khi không tải dữ liệu
                }
              });
        },
      ),
    );
  }

  void handleSearchMovie(String keyword) {
    provider.resetData();
    provider.searchMovie(keyword: keyword, page: 1, limit: LIMIT_SEARCH_RESULT);
  }
}
