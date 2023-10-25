import 'package:flutter/material.dart';
import 'package:new_nabni_app/core/constant/appcolors.dart';
import 'package:new_nabni_app/view/widgets/appbanner.dart';

class BannerItem extends StatelessWidget {
  final AppBanner appBanner;
  const BannerItem({
    super.key,
    required this.appBanner,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        border: Border.all(
          color: AppColors.cloroFrame, // لون الإطار هنا
          width: 1.0, // عرض الإطار هنا
        ),
        image: DecorationImage(
          image: AssetImage(appBanner.thumbnailUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
