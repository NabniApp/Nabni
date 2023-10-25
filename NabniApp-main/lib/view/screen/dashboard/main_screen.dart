import 'package:flutter/material.dart';
import "package:curved_navigation_bar/curved_navigation_bar.dart";
import 'package:get/get.dart';
import 'package:new_nabni_app/controller/auth_controller.dart';
import 'package:new_nabni_app/utiles/app_constants.dart';
import 'package:new_nabni_app/utiles/route_helper.dart';
import 'package:new_nabni_app/view/screen/client/client_home_screen.dart';
import 'package:new_nabni_app/view/screen/client/client_invoices_screen.dart';
import 'package:new_nabni_app/view/screen/client/orders_screen.dart';
import 'package:new_nabni_app/view/screen/communication/communication_screen.dart';
import 'package:new_nabni_app/view/screen/contractor/contractor_home_screen.dart';
import 'package:new_nabni_app/view/screen/contractor/contractor_invoices_screen.dart';

import 'package:new_nabni_app/view/screen/contractor/requests_contractor.dart';
import 'package:new_nabni_app/view/screen/supplier/requests_supplier_screen.dart';
import 'package:new_nabni_app/view/screen/supplier/supplier_home_screen.dart';
import 'package:new_nabni_app/view/screen/supplier/supplier_invoice_screen.dart';

class MainScreen extends StatefulWidget {
  final user_type;
  const MainScreen({Key? key, required this.user_type}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List<Widget> pages = [
    ContractorHomeScreen(),
    RequestsScreen(),
    Communication(),
    ContractorInvoicesScreen()
  ];

  List<String> pagesTitle = [
    'الصفحة الرئيسية',
    'الطلبات',
    'الرسائل',
    'الفواتير',
  ];

  List<PopupMenuEntry> popupItems = [];

  @override
  void initState() {
    if (widget.user_type == AppConstants.userTypes[0]) {
      // SUPPLIER
      pages = [
        SupplierHomeScreen(),
        RequestsSupplierScreen(),
        Communication(),
        SupplierInvoiceScreen()
      ];
      popupItems = [
        PopupMenuItem(
          child: _buildPopupMenuItem('سجل المواد', Icons.subject),
          value: 'subject_history',
        ),
        PopupMenuItem(
          child:
              _buildPopupMenuItem('اضافة مادة جديدة', Icons.note_add_outlined),
          value: 'add_new_subject',
        ),
        PopupMenuItem(
          child: _buildPopupMenuItem(' الملف الشخصي', Icons.person),
          value: 'supplier_profile',
        ),
        PopupMenuItem(
          child: _buildPopupMenuItem('تسجيل الخروج', Icons.exit_to_app),
          value: 'logout',
        ),
      ];
    } else if (widget.user_type == AppConstants.userTypes[2]) {
      // Client
      pages = [
        ClientHomeScreen(),
        OrdersScreen(),
        Communication(),
        ClientInvoicesScreen()
      ];
      popupItems = [
        PopupMenuItem(
          child: _buildPopupMenuItem(' الملف الشخصي', Icons.person),
          value: 'client_profile',
        ),
        PopupMenuItem(
          child: _buildPopupMenuItem('تسجيل الخروج', Icons.exit_to_app),
          value: 'logout',
        ),
      ];
    } else {
      popupItems = [
        PopupMenuItem(
          child: _buildPopupMenuItem('سجل الأعمال', Icons.note_add_outlined),
          value: 'work_contractor_history',
        ),
        PopupMenuItem(
          child: _buildPopupMenuItem(' الملف الشخصي', Icons.person),
          value: 'contractor_profile',
        ),
        PopupMenuItem(
          child: _buildPopupMenuItem('تسجيل الخروج', Icons.exit_to_app),
          value: 'logout',
        ),
      ];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 254, 253, 249),
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            elevation: 1, //الشادو
            title: Text(pagesTitle[_selectedIndex]),
            titleTextStyle: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
                color: const Color.fromARGB(255, 139, 124, 97)),
            centerTitle: true,
            actions: [
              PopupMenuButton(
                icon: const Icon(
                  Icons.dehaze_sharp,
                  color: const Color.fromARGB(255, 139, 124, 97),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                offset: Offset(0, 57), // تحويل عمودي للقائمة

                itemBuilder: (BuildContext context) {
                  return popupItems;
                },
                onSelected: (value) {
                  if (value == 'subject_history') {
                    Get.toNamed(RouteHelper.getSubjectHistoryRoute());
                  } else if (value == 'add_new_subject') {
                    Get.toNamed(RouteHelper.getAddNewMaterialRoute());
                  } else if (value == 'supplier_profile') {
                    Get.toNamed(RouteHelper.getSupplierProfileRoute());
                  } else if (value == 'client_profile') {
                    Get.toNamed(RouteHelper.getClientProfileRoute());
                  } else if (value == 'work_contractor_history') {
                    Get.toNamed(RouteHelper.getContractorWorksHistoryRoute());
                  } else if (value == 'contractor_profile') {
                    Get.toNamed(RouteHelper.getContractorProfileRoute());
                  } else if (value == 'add_new_work') {
                    Get.toNamed(RouteHelper.getAddNewWorkRoute());
                  } else if (value == 'logout') {
                    Get.find<AuthController>().signOut(context);
                  }
                },
              ),
            ],
            leading: IconButton(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              onPressed: () {},
              icon: Image.asset(ImageAsset.appBarLogo),
            )),
        body: pages[_selectedIndex],
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: const Color.fromARGB(255, 139, 124, 97),
          height: 50,
          items: const <Widget>[
            Icon(Icons.home,
                size: 25, color: Color.fromARGB(255, 139, 124, 97)),
            Icon(Icons.list_alt,
                size: 25, color: Color.fromARGB(255, 139, 124, 97)),
            Icon(Icons.chat,
                size: 25, color: Color.fromARGB(255, 139, 124, 97)),
            Icon(Icons.newspaper,
                size: 25, color: Color.fromARGB(255, 139, 124, 97)),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }

  Widget _buildPopupMenuItem(String menuTitle, IconData iconData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          menuTitle,
          style: const TextStyle(
            color: Color.fromARGB(255, 139, 124, 97),
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
          ),
        ),
        const SizedBox(width: 8),
        Icon(
          iconData,
          color: Color.fromARGB(255, 139, 124, 97),
        ),
      ],
    );
  }
}
