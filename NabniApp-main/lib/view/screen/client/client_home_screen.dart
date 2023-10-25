import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/controller/client_controller.dart';
import 'package:new_nabni_app/controller/supplier_controller.dart';
import 'package:new_nabni_app/data/model/project_model.dart';
import 'package:new_nabni_app/data/model/user_model.dart';
import 'package:new_nabni_app/utiles/app_constants.dart';
import 'package:new_nabni_app/utiles/route_helper.dart';

import 'package:new_nabni_app/view/widgets/appbanner.dart';
import 'package:new_nabni_app/view/widgets/banner_item.dart';
import 'package:new_nabni_app/view/widgets/indicator.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({super.key});

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  //هنا المتغيرات حطيتها بشكل حطيت قيم بشكل افتراضي و بعد الربط القواعد تنحذف القيم
  var _selectedIndex = 0;
  String projectName = 'مشروع سابق 1'; // متغير مشروع جديد
  String clientName = 'اسم العميل: عبدالرحمن الغامدي'; // متغير اسم العميل
  String executionDuration = 'مدة التنفيذ: جاري التنفيذ'; //متغير مدة التنفيد
  String orderStatus = 'حالة الطلب: قيد الإنتظار'; // متغير حالة الطلب
  String companyName = 'اسم شركة المورد   '; // متغير اسم الشركة
  // ignore: unused_field
  final int _currentIndex = 0;

  @override
  void initState() {
    Get.find<SupplierController>()
        .getContractorsOrSuppliers(AppConstants.userTypes[1]);
    Get.find<ClientController>().getProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20.0),
              height: 160,
              child: PageView.builder(
                onPageChanged: (index1) {
                  setState(() {
                    _selectedIndex = index1;
                  });
                },
                controller: PageController(viewportFraction: 1),
                itemCount: appBannerList.length,
                itemBuilder: (context, index) {
                  var benner = appBannerList[index];
                  var _scale = _selectedIndex == index ? 1.0 : 0.8;

                  return TweenAnimationBuilder(
                    duration: const Duration(milliseconds: 350),
                    tween: Tween(begin: _scale, end: _scale),
                    curve: Curves.ease,
                    child: BannerItem(
                      appBanner: benner,
                    ),
                    builder: (context, value, child) {
                      return Transform.scale(scale: value, child: child);
                    },
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                    appBannerList.length,
                    (index2) => Indicator(
                        isActive: _selectedIndex == index2 ? true : false))
              ],
            ),

            const SizedBox(
              height: 30,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'المقاولين',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 139, 124, 97),
                      fontFamily: 'Cairo'),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(RouteHelper.getContractorsRoute());
                  },
                  child: Text(
                    'المزيد',
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 139, 124, 97),
                        fontFamily: 'Cairo'),
                  ),
                ),
              ],
            ),

            GetBuilder<SupplierController>(builder: (controller) {
              return controller.contractors == null
                  ? CircularProgressIndicator()
                  : SizedBox(
                      height: 170, // زيادة الارتفاع لاحتواء الأيقونة
                      child: ListView.builder(
                        itemCount: controller.contractors!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return _contractorItem(
                              controller.contractors![index]);
                        },
                      ),
                    );
            }),

            const SizedBox(
              height: 30,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'المشاريع',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 139, 124, 97),
                      fontFamily: 'Cairo'),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(RouteHelper.getProjectsHistoryRoute());
                  },
                  child: Text(
                    'المزيد',
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 139, 124, 97),
                        fontFamily: 'Cairo'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            // هنا ايضا افتراضي لمن يسجل مورد جديد تناضاف اثنين هنا وثلاث مربع يكون المزيد وتذهب لصفحة الشركات
            GetBuilder<ClientController>(builder: (controller) {
              return controller.isLoading
                  ? CircularProgressIndicator()
                  : SizedBox(
                      height: 190, // زيادة الارتفاع لاحتواء الأيقونة
                      child: ListView.builder(
                        itemCount: controller.projects.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return _projectItem(
                              index + 1, controller.projects[index]);
                        },
                      ),
                    );
            }),
          ]),
        ),
      ),
    );
  }

  Widget _projectItem(index, ProjectModel model) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, spreadRadius: 1, blurRadius: 5)
        ],
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.home,
                  color: Color(0xff8B7C61),
                  size: 25,
                ),
                const SizedBox(
                  width: 7,
                ),
                Text('مشروع #$index',
                    style: TextStyle(
                        color: Color(0xff8B7C61),
                        fontFamily: 'Cairo',
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            _rowItem('اسم المقاول: ', model.contractor_name, false),
            _rowItem('مدة التنفيذ: ', typeStatus(model.status), false),
            const SizedBox(
              height: 10,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text('حالة الطلب: ${getStatus(model.status)}',
                    style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16,
                        color: Color(0xff8B7C61)))),
          ]),
    );
  }

  Widget _rowItem(key, value, isLink) {
    return Row(
      children: [
        Text(key,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 16,
            )),
        const SizedBox(
          width: 7,
        ),
        if (!isLink)
          Text(value, style: TextStyle(fontFamily: 'Cairo', fontSize: 14)),
        if (isLink)
          InkWell(
              onTap: () {},
              child: Text(
                value,
                style: TextStyle(
                    fontFamily: 'Cairo', fontSize: 15, color: Colors.blue),
              )),
      ],
    );
  }

  Widget _contractorItem(UserModel model) {
    return InkWell(
        onTap: () {
          Get.toNamed(RouteHelper.getSingleContractorRoute(model));
        },
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            border: Border.all(
              color: Color.fromARGB(255, 240, 240, 240),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(
                  ImageAsset.appBarLogo,
                  height: 80,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                model.username!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
        ));
  }

  String? typeStatus(status) {
    String _status = 'جاري التنفيذ';
    if (status == 'finished') {
      _status = 'تم الانتهاء';
    } else if (status == 'rejected') {
      _status = 'تم الرفض';
    }

    return _status;
  }

  String getStatus(status) {
    String _status = '';
    if (status == 'under_review') {
      _status = 'تحت المراجعة';
    } else if (status == 'rejected') {
      _status = 'مرفوض';
    } else if (status == 'in_deal') {
      _status = 'يتم التفاوض';
    } else if (status == 'done_deal') {
      _status = 'تم القبول';
    } else if (status == 'finished') {
      _status = 'تم الانتهاء';
    }

    return _status;
  }
}
