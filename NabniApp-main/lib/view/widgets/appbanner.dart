import 'package:new_nabni_app/utiles/app_constants.dart';

class AppBanner {
  final int id;
  final String title;
  final String thumbnailUrl;
  AppBanner(this.id, this.title, this.thumbnailUrl);
}

// ادراج الصور
List<AppBanner> appBannerList = [
  AppBanner(1, 'Title', ImageAsset.homepageBanner1),
  AppBanner(2, 'Title', ImageAsset.homepageBanner2),
  AppBanner(3, 'Title', ImageAsset.homepageBanner3),
  AppBanner(4, 'Title', ImageAsset.homepageBanner4),
];
