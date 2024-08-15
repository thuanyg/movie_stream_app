import 'package:flutter/material.dart';
import 'package:movie_stream/configs/app_colors.dart';
import 'package:movie_stream/helpers/image_helper.dart';
import 'package:movie_stream/providers/movie/movie_provider.dart';
import 'package:movie_stream/ui/pages/detail/detail_page.dart';
import 'package:movie_stream/ui/widgets/progress_indicator.dart';
import 'package:provider/provider.dart';

import '../../../../configs/app_styles.dart';

class AllMoviesByGenre extends StatefulWidget {
  final String genre, title;

  const AllMoviesByGenre({
    super.key,
    required ScrollController bottomSheetScrollController,
    required this.title,
    required this.genre,
  }) : _bottomSheetScrollController = bottomSheetScrollController;

  final ScrollController _bottomSheetScrollController;

  @override
  State<AllMoviesByGenre> createState() => _AllMoviesByGenreState();
}

class _AllMoviesByGenreState extends State<AllMoviesByGenre> {
  late MovieProvider provider;

  void _onScroll() {
    if (widget._bottomSheetScrollController.position.pixels ==
        widget._bottomSheetScrollController.position.maxScrollExtent) {
      provider.loadMoreGenreMovie(widget.genre);
    }
  }

  @override
  void initState() {
    super.initState();
    provider = Provider.of<MovieProvider>(context, listen: false);
    widget._bottomSheetScrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.85,
      width: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width / 3.5),
              child: const Divider(thickness: 2, color: Colors.grey),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: AppStyles.titleAppBar.copyWith(
                      color: Colors.white60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.white54,
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: SingleChildScrollView(
                  controller: widget._bottomSheetScrollController,
                  child: Consumer<MovieProvider>(
                    builder: (context, provider, child) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        child: Column(
                          children: [
                            GridView.builder(
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                                childAspectRatio: 0.75,
                              ),
                              itemCount: provider.listMovieByGenre.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        DetailPage.routeName,
                                        arguments: provider
                                            .listMovieByGenre[index].slug);
                                  },
                                  child: Stack(
                                    children: [
                                      Opacity(
                                        opacity: .6,
                                        child: Center(
                                          child: ImageHelper.loadNetworkImage(
                                            "https://phimimg.com/${provider.listMovieByGenre[index].posterUrl!}",
                                            radius: BorderRadius.circular(10),
                                            height: 200,
                                            width: 150,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              bottom: 2.0, left: 10, right: 10),
                                          child: Text(
                                            provider
                                                .listMovieByGenre[index].name!,
                                            style: AppStyles.heading5.copyWith(
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
                              },
                            ),
                            Consumer<MovieProvider>(
                              builder: (context, value, child) =>
                                  value.isSeeAllLoading
                                      ? Container(
                                          margin: const EdgeInsets.all(8.0),
                                          child: const Center(
                                            child:
                                                CustomLoadingProgress(),
                                          ),
                                        )
                                      : Container(),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
