import 'package:flutter/material.dart';
import 'package:movie_stream/configs/app_colors.dart';
import 'package:movie_stream/configs/app_styles.dart';

class Category extends StatelessWidget {
  const Category({
    super.key,
    required this.categoryName,
    required this.onSeeAll,
  });

  final String categoryName;
  final VoidCallback onSeeAll;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height / 18,
      child: Row(
        children: [
          Expanded(
            child: Text(categoryName,
                style:
                    AppStyles.heading3.copyWith(fontWeight: FontWeight.bold)),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onSeeAll,
            child: Text(
              "Tất cả >",
              style:
                  AppStyles.heading4.copyWith(color: AppColors.textHintColor),
            ),
          )
        ],
      ),
    );
  }
}
