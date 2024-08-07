import 'package:flutter/material.dart';
import 'package:movie_stream/configs/app_colors.dart';
import 'package:movie_stream/configs/app_styles.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: size.height / 16,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: const Color.fromARGB(255, 58, 54, 79),
          border:
              Border.all(color: AppColors.textHintColor, width: .2)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            Image.asset(
              "assets/images/icon_search.png",
              color: Colors.white,
              width: 24,
              fit: BoxFit.fitWidth,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: searchController,
                maxLines: 1,
                style: AppStyles.heading3,
                cursorColor: AppColors.textColor,
                decoration: InputDecoration(
                  hintText: 'Search movies',
                  hintStyle: AppStyles.heading3
                      .copyWith(color: AppColors.textHintColor),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}