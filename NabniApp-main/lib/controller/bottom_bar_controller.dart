import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/view/screen/communication/communication_screen.dart';
import 'package:new_nabni_app/view/screen/contractor/contractor_home_screen.dart';
import 'package:new_nabni_app/view/screen/contractor/requests_contractor.dart';

class BottomBarController extends GetxController {
  int? selectedIndex = 0;
  List<Widget> pages = [
    // const Invoice(),
    const Communication(),
    const RequestsScreen(),
    ContractorHomeScreen(),
  ];
  List icons = [Icons.newspaper, Icons.chat, Icons.list_alt, Icons.home];

  onChange(int page) {
    selectedIndex = page;
    update();
  }
}
