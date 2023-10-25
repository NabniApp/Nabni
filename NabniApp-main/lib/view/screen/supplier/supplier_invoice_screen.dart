import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/controller/supplier_controller.dart';
import 'package:new_nabni_app/data/model/material_model.dart';
import 'package:new_nabni_app/utiles/route_helper.dart';

class SupplierInvoiceScreen extends StatefulWidget {
  const SupplierInvoiceScreen({Key? key}) : super(key: key);

  @override
  State<SupplierInvoiceScreen> createState() => _SupplierInvoiceScreenState();
}

class _SupplierInvoiceScreenState extends State<SupplierInvoiceScreen> {
  @override
  void initState() {
    Get.find<SupplierController>().getRequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<SupplierController>(builder: (controller) {
        return controller.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : controller.requests.isNotEmpty
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: controller.requests.length,
                    itemBuilder: (context, index) {
                      return _item(
                          index + 1, controller.requests[index], controller);
                    },
                  )
                : Center(child: Text('لا يوجد فواتير'));
      }),
    );
  }

  Widget _item(int index, MaterialModel model, controller) {
    return InkWell(
      onTap: () {
        Get.toNamed(RouteHelper.getSupplierInvoiceRoute(
            controller.requests, model.username));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          border: Border.all(
            color: Color.fromARGB(255, 240, 240, 240),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.copy,
              size: 30,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'فاتورة: #$index',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff8B7C61),
                    fontFamily: 'Cairo',
                  ),
                ),
                Text(
                  model.username ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
