import 'dart:async';

import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/utiles/app_constants.dart';
import 'package:new_nabni_app/utiles/route_helper.dart';
import 'package:new_nabni_app/view/widgets/myimage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utiles/preference.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  String? seen;
  int? index;
  Preference sharePref = Preference.shared;
  late Animation<double> animation;
  late AnimationController controller;

  @override
  initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5))
          ..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    initSetting();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 254, 253, 249),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: ScaleTransition(
            scale: animation,
            child: Center(
              child: MyImage(
                  width: 300,
                  height: 300,
                  fit: BoxFit.fill,
                  imagePath: ImageAsset.logo),
            )),
      ),
    );
  }

  initSetting() async {
    final seen = sharePref.getString(AppConstants.SEEN) ?? "0";
    final isLogin = sharePref.getString(AppConstants.IS_LOGIN) ?? "0";
    final isIntro = sharePref.getString(AppConstants.IS_INTRO) ?? "0";
    final user_type = sharePref.getString(AppConstants.USER_TYPE) ??
        AppConstants.userTypes[0];
    final delayDuration = Duration(seconds: 3);

    Future<void> navigateToRoute(String routeName) async {
      Timer(delayDuration, () => Get.offAndToNamed(routeName));
    }

    if (seen == "1") {
      final initialRoute = isLogin == "1"
          ? RouteHelper.getInitialRoute(user_type: user_type)
          : RouteHelper.getLoginRoute();

      await navigateToRoute(initialRoute);
    } else {
      await navigateToRoute(RouteHelper.getOnBoardingRoute());
    }
  }
}
