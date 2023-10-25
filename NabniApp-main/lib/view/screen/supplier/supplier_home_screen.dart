import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/controller/supplier_controller.dart';
import 'package:new_nabni_app/data/model/material_model.dart';
import 'package:new_nabni_app/data/model/user_model.dart';
import 'package:new_nabni_app/utiles/app_constants.dart';
import 'package:new_nabni_app/utiles/route_helper.dart';

import 'package:new_nabni_app/view/widgets/appbanner.dart';
import 'package:new_nabni_app/view/widgets/banner_item.dart';
import 'package:new_nabni_app/view/widgets/indicator.dart';

class SupplierHomeScreen extends StatefulWidget {
  const SupplierHomeScreen({super.key});

  @override
  State<SupplierHomeScreen> createState() => _SupplierHomeScreenState();
}

class _SupplierHomeScreenState extends State<SupplierHomeScreen> {
  var _selectedIndex = 0;
  final int _currentIndex = 0;

  @override
  void initState() {
    Get.find<SupplierController>()
        .getContractorsOrSuppliers(AppConstants.userTypes[1]);
    Get.find<SupplierController>().getMaterials();

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
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'المواد',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 139, 124, 97),
                      fontFamily: 'Cairo'),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(RouteHelper.getAddNewMaterialRoute());
                  },
                  child: Text(
                    'اضافة مادة',
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 139, 124, 97),
                        fontFamily: 'Cairo'),
                  ),
                ),
              ],
            ),
            GetBuilder<SupplierController>(builder: (controller) {
              return controller.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : controller.materials.isNotEmpty
                      ? SizedBox(
                          height: 200,
                          child: ListView.builder(
                              itemCount: controller.materials.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return _materialItem(
                                    controller.materials[index], controller);
                              }),
                        )
                      : Center(child: Text('Not Found any material'));
            }),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
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
                      height: 170,
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
          ]),
        ),
      ),
    );
  }

  Widget _materialItem(MaterialModel model, SupplierController controller) {
    return InkWell(
        onTap: () {},
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
                child: Image.network(
                  model.image!,
                  height: 80,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                model.username!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontFamily: 'Cairo',
                ),
              ),
              Text(
                '${model.price} ريال',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff8B7C61),
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
        ));
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
}
