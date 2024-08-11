import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_stream/configs/app_colors.dart';
import 'package:movie_stream/configs/app_styles.dart';
import 'package:movie_stream/ui/pages/detail/components/movie_play.dart';
import 'package:movie_stream/ui/pages/detail/components/movie_title.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  static const String routeName = '/DetailPage';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff15141F),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            MoviePlay(),
            MovieTitle(movieTitle: "Star Wars: The Last Jedi", quality: "HD"),
            TimeAndRate(
              time: "45 Phút/Tập",
              rate: "7.0 (IMDb)",
            ),
            Divider(
              height: 36,
              endIndent: 24,
              indent: 24,
              thickness: .06,
              color: Colors.grey,
            ),
            GenreAndDate(
              releaseDate: "December 9, 2017",
            ),
            Divider(
              height: 36,
              endIndent: 24,
              indent: 24,
              thickness: .06,
              color: Colors.grey,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Synopsis",
                    style: TextStyle(
                      fontFamily: 'Lato',
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "\"Tứ Hải Trọng Minh\" là bộ phim kiếm hiệp cổ trang do Vân Đức Quang đạo diễn có sự tham gia của Cảnh Điềm, Trương Lăng Hách, Quan Hồng, Xương Long... Bộ phim được chuyển thể từ tiểu thuyết “Tôi có ba con ngựa tre” kể về câu chuyện của một cô gái trẻ tên Nam Nhan, người dấn thân vào hành trình bất tử để cứu mẹ mình, nhưng vô tình lại kết thành phu thê với Kê Dương. Để cứu mẹ, Nam Nhan buộc phải dấn thân vào con đường trường sinh, tuy nhiên do sai lầm nào đó, cô đã gieo mầm mống hôn nhân với Kê Dương. Trong hai người, một người kiêu ngạo, lạnh lùng và tâm linh, người kia thích tìm kiếm kiến thức y dược. Hai người vốn không ưa nhau cũng vướng vào một âm mưu trong quá trình truy tìm căn bệnh của mẹ Nam Nhan.",
                    maxLines: 8,
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textHintColor,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Director",
                    style: TextStyle(
                      fontFamily: 'Lato',
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "De-Guang Wen",
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textHintColor,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Casts",
                    style: TextStyle(
                      fontFamily: 'Lato',
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Cảnh Điềm, Trương Lăng Hách, Trần Quan Hồng, Chang Long, Kiều Chấn Vũ",
                    textAlign: TextAlign.justify,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textHintColor,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Language",
                    style: TextStyle(
                      fontFamily: 'Lato',
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Vietsub + Thuyết Minh",
                    textAlign: TextAlign.justify,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textHintColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GenreAndDate extends StatelessWidget {
  final String releaseDate;
  final List<String> genres;

  const GenreAndDate({
    required this.releaseDate,
    this.genres = const [
      "Lãng Mạn",
      "Cổ Trang",
    ], // Giá trị mặc định
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Release date",
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              Text(
                releaseDate,
                style: const TextStyle(
                  color: AppColors.textHintColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Genre",
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  for (var genre in genres)
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Text(
                        genre,
                        style: const TextStyle(
                          color: AppColors.textHintColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TimeAndRate extends StatelessWidget {
  final String time, rate;

  const TimeAndRate({
    required this.time,
    required this.rate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          const Icon(Icons.access_time, size: 16, color: Colors.grey),
          const SizedBox(width: 3.0),
          Text(
            time,
            style: const TextStyle(
              color: AppColors.textHintColor,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 20.0),
          const Icon(Icons.star, size: 16, color: Colors.grey),
          const SizedBox(width: 3.0),
          Text(
            rate,
            style: const TextStyle(
              color: AppColors.textHintColor,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 20.0),
          const Icon(Icons.token_sharp, size: 16, color: Colors.grey),
          const SizedBox(width: 3.0),
          const Text(
            "15/36 Episode",
            style: TextStyle(
              color: AppColors.textHintColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
