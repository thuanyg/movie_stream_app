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
const String MOVIE_API_URL = "https://phimapi.com"; // hidden API. Contact to email thuanht.nuce@gmail.com to obtain it.

const int LIMIT_INITIAL = 18;
const int LIMIT_SEARCH_RESULT = 20;

const String PHIM_BO = "phim-bo";
const String PHIM_LE = "phim-le";
const String PHIM_HOAT_HINH = "hoat-hinh";
const String TV_SHOWS = "tv-shows";

const String HANH_DONG = "hanh-dong";
const String CO_TRANG = "co-trang";
const String HOC_DUONG = "hoc-duong";
const String HAI_HUOC = "hai-huoc";
const String KINH_DI = "kinh-di";
const String TAM_LY = "tam-ly";
const String VIEN_TUONG = "vien-tuong";

const Map<String, String> categories = {
  HANH_DONG: "Hành động",
  CO_TRANG: "Cổ trang",
  HOC_DUONG: "Học đường",
  HAI_HUOC: "Hài hước",
  KINH_DI: "Kinh dị",
  TAM_LY: "Tâm lý",
  VIEN_TUONG: "Viễn tưởng"
};

// DataStorage
const String USER_TOKEN_KEY = "userToken";
