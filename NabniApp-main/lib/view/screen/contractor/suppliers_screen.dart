import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/controller/supplier_controller.dart';
import 'package:new_nabni_app/data/model/user_model.dart';
import 'package:new_nabni_app/utiles/app_constants.dart';
import 'package:new_nabni_app/utiles/route_helper.dart';

class SuppliersScreen extends StatefulWidget {
  const SuppliersScreen({super.key});

  @override
  State<SuppliersScreen> createState() => _SuppliersScreenState();
}

class _SuppliersScreenState extends State<SuppliersScreen> {
  @override
  void initState() {
    Get.find<SupplierController>().filterSuppliers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 254, 253, 249),
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: .7,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xff8B7C61),
              )),
          title: Text(
            'الموردين',
            style: TextStyle(color: Color(0xff8B7C61), fontWeight: FontWeight.bold, fontSize: 17,fontFamily: 'Cairo'),
          ),
          actions: [],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GetBuilder<SupplierController>(builder: (controller) {
                    return controller.isLoading
                        ? const CircularProgressIndicator()
                        : controller.allSuppliers == null
                            ? const Text('لا يوجد موردين')
                            : SizedBox(
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        2, // Number of items in each row
                                    crossAxisSpacing:
                                        10.0, // Space between columns
                                    mainAxisSpacing: 10.0, // Space between rows
                                  ),
                                  itemCount: controller.allSuppliers!.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return _supplierItem(
                                        controller.allSuppliers![index]);
                                  },
                                ),
                              );
                  }),
                ]),
          ),
        ),
      ),
    );
  }

  Widget _supplierItem(UserModel model) {
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
                  width: 100,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                model.username!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
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
