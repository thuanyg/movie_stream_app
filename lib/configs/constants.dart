// Create a list of onboarding pages
import 'package:movie_stream/models/onboarding.dart';

const List<Onboarding> onboardingPages = [
  Onboarding(
    title: 'Chào mừng đến với WatchEz',
    description: 'Khám phá hàng ngàn bộ phim và chương trình truyền hình hấp dẫn.',
    imageAssetPath: 'assets/onboarding/onboarding_img_1.png',
  ),
  Onboarding(
    title: 'Xem phim bất cứ lúc nào',
    description: 'Thưởng thức nội dung yêu thích của bạn mọi lúc, mọi nơi.',
    imageAssetPath: 'assets/onboarding/onboarding_img_2.png',
  ),
  Onboarding(
    title: 'Danh sách phim yêu thích',
    description: 'Dễ dàng lưu và quản lý danh sách phim bạn yêu thích.',
    imageAssetPath: 'assets/onboarding/onboarding_img_3.png',
  ),
];

// API
const String APP_BASE_URL = "https://watchez.onrender.com/watchez";
const String MOVIE_API_URL = "https://phimapi.com";

const int LIMIT_SEARCH_RESULT = 20;
const String PHIM_BO = "phim-bo";
const String PHIM_LE = "phim-le";
const String PHIM_HOAT_HINH = "hoat-hinh";
const String TV_SHOWS = "tv-shows";


// DataStorage
const String USER_TOKEN_KEY = "userToken";