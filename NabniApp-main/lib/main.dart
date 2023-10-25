import 'dart:io';

import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/utiles/app_constants.dart';
import 'package:new_nabni_app/utiles/preference.dart';
import 'package:new_nabni_app/utiles/route_helper.dart';
import 'package:new_nabni_app/utiles/theme_model.dart';
import 'package:new_nabni_app/view/screen/client/3d_view_screen.dart';
import 'package:new_nabni_app/view/screen/client/client_invoce_info.dart';
import 'utiles/get_di.dart' as di;
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart' as cc;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();
  await Preference().instance();

  await Firebase.initializeApp();

  await di.init();
  initCometChat();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.APP_NAME,
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.key,
      initialRoute: RouteHelper.getSplashRoute(),
      // home: Cube3D(),
      getPages: RouteHelper.routes,
      defaultTransition: Transition.topLevel,
      theme: ThemeModel().lightMode, // Provide light theme.
      transitionDuration: Duration(milliseconds: 500),
    );
  }
}

void initCometChat() async {
  AppSettings appSettings = (AppSettingsBuilder()
        ..subscriptionType = CometChatSubscriptionType.allUsers
        ..region = AppConstants.COMETCHAT_REGION
        ..autoEstablishSocketConnection = true)
      .build();

  CometChat.init(AppConstants.COMETCHAT_APP_ID, appSettings,
      onSuccess: (String successMessage) async {
    debugPrint("Initialization completed successfully  $successMessage");
    if (Preference.shared.getString(AppConstants.USER_ID) != null) {
      await cc.CometChat.login(
          Preference.shared.getString(AppConstants.USER_ID)!,
          AppConstants.COMETCHAT_AUTH_KEY, onSuccess: (cc.User user) {
        debugPrint("Login Successful : $user");
      }, onError: (cc.CometChatException e) {
        debugPrint("Login failed with exception:  ${e.message}");
      });
    }
  }, onError: (CometChatException e) {
    debugPrint("Initialization failed with exception: ${e.message}");
  });
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}