import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppConstants {
  static const APP_NAME = 'Nabni';

  static const IS_LOGIN = 'USER_IS_LOGIN';
  static const USER_ID = 'USER_ID';
  static const USER_NAME = 'USER_NAME';
  static const SEEN = 'SEEN';
  static const IS_INTRO = 'IS_INTRO';
  static const USER_TYPE = 'USER_TYPE';
  static const languageEn = "en";
  static const countryCodeEn = "US";

  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';

  static const String HELP_PHONE = '+9660000232';
  static const String HELP_EMAIL = 'test@example.com';

  static const String COMETCHAT_APP_ID = "24557885c897253a";
  static const String COMETCHAT_REGION = "US";
  static const String COMETCHAT_AUTH_KEY =
      "95674cccbba32bc94bf028f8a0c2bebaf2a78564";

  static const userTypes = [
    "SUPPLIER",
    "CONTRACTOR",
    "CLIENT",
  ];

  static const List<String> cities = [
    'مكة',
  ];

  static const List<String> materials = [
    'بلاط',
    'الحديد',
    'بويه',
    'طوب',
    'اسمنت',
  ];

  static const List<String> materialsFor3D = [
    'بلاط',
    'بويه',
  ];

  static const List<String> gender = [
    'أنثى',
    'ذكر',
  ];
}

class ImageAsset {
  static const String rootImages = "assets/images";

  static const String onBoardingImageOne = "assets/images/contractor.png";
  static const String onBoardingImageTwo = "assets/images/clients.png";
  static const String onBoardingImageThree = "assets/images/suppliers.png";
  static const String onBoardingImageBack = "assets/images/Back.jpg";
  static const String appBarLogo = "assets/images/m1.png";
  static const String homepageBanner1 = "assets/images/m2.png";
  static const String homepageBanner2 = "assets/images/m3.png";
  static const String homepageBanner3 = "assets/images/m4.png";
  static const String homepageBanner4 = "assets/images/m5.jpg";
  static String logo = 'assets/images/m1.png';
}

void openGoogleMaps(double latitude, double longitude) async {
  final url =
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch Google Maps';
  }
}
