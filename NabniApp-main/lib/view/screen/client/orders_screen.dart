import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/controller/client_controller.dart';
import 'package:new_nabni_app/data/model/project_model.dart';
import 'package:new_nabni_app/data/model/material_model.dart';
import 'package:new_nabni_app/utiles/app_constants.dart';
import 'package:new_nabni_app/utiles/route_helper.dart';
import 'package:new_nabni_app/view/widgets/custom_snackbar.dart';
import 'package:new_nabni_app/view/widgets/dialog_done_project.dart';
import 'package:new_nabni_app/view/widgets/show_image_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController review = TextEditingController();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            GetBuilder<ClientController>(builder: (controller) {
              return controller.isLoading
                  ? const CircularProgressIndicator()
                  : controller.projects.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.projects.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return _itemOrder(index + 1,
                                controller.projects[index], controller);
                          },
                        )
                      : Center(child: Text('لا يوجد طلبات',style: TextStyle(
                        color: Colors.black ,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)));
            }),
          ]),
        ),
      ),
    );
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
      _status = 'تم الإنتهاء';
    }

    return _status;
  }

  Widget _itemOrder(index, ProjectModel model, ClientController controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, spreadRadius: 1, blurRadius: 5)
        ],
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
            Spacer(),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(getStatus(model.status),
                    style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff8B7C61)))),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        _rowItem('حجم المشروع: ', '563 م', false),
        _rowItem('الموقع: ', 'رابط الموقع', true,
            map: true, lat: model.lat, lng: model.lng),
        _rowItem('الميزانية المقترحة: ', '${model.price} ريال', false),
        _rowItem('اثبات الملكية: ', 'اضغط هنا', true,
            url: model.imageIdentity!),
        _rowItem('رخصة البناء: ', 'اضغط هنا', true, url: model.imageLicence!),
        _rowItem('الخرائط: ', 'اضغط هنا', true, url: model.imageMap!),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            if (!controller.isLoading &&
                !model.isReviewAndEnd! &&
                model.status == 'finished')
              Expanded(
                child: InkWell(
                  onTap: () {
                    controller
                        .getUserData(id: model.contractor_id)
                        .then((contractor_model) {
                      showDoneProjectDialog(
                          context, contractor_model, model.id!);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      'انهاء وتقييم',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Cairo',
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            if (!controller.isLoading &&
                !model.isReviewAndEnd! &&
                model.status == 'done_deal')
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.toNamed(RouteHelper.getProjectProgressRoute(model.id!));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      'تتبع المشروع',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Cairo',
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            if (!controller.isLoading && model.status == 'done_deal')
              SizedBox(
                width: 5,
              ),
            if (!controller.isLoading && model.status == 'done_deal')
              Expanded(
                child: InkWell(
                  onTap: () {
                    controller.getContractImage(model.id).then((url) {
                      if (url == null) {
                        showCustomSnackBar(context, 'لا يوجد عقد حتي الان');
                      } else {
                        // showImageDialog(context, url);
                        Get.toNamed(RouteHelper.getPdfViewerScreenRoute(url));
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      'العقد',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Cairo',
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            if (!controller.isLoading && model.status == 'done_deal')
              SizedBox(
                width: 5,
              ),
            if (!controller.isLoading && model.status == 'done_deal')
              Expanded(
                child: InkWell(
                  onTap: () {
                    controller
                        .getInvoiceDataForClient(
                            model.id!, model.contractor_id!)
                        .then((data) {
                      if (data != 'error' && data.isNotEmpty) {
                        // Use data.isNotEmpty to check for a non-empty list
                        final materialItems =
                            data['materialItems'] as List<MaterialModel>;
                        final priceWork = data['priceWork'];

                        Get.offAndToNamed(RouteHelper.getInvoiceRoute(
                            materialItems,
                            'اسم العميل',
                            model.client_id,
                            model.id,
                            priceWork,
                            justShow: true,
                            invoice_id: data['invoice_id'],
                            isConfirmedByClient:
                                data['is_confirmed_by_client']));
                      } else {
                        showCustomSnackBar(context, 'لا يوجد فاتورة حتى الآن');
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      'الفاتورة',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Cairo',
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ]),
    );
  }

  Widget _rowItem(key, value, isLink, {url, map = false, lat, lng}) {
    return Row(
      children: [
        Text(key,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 16,
            )),
        const SizedBox(
          width: 7,
        ),
        if (!isLink)
          Text(value,
              style: const TextStyle(fontFamily: 'Cairo', fontSize: 14)),
        if (isLink)
          InkWell(
              onTap: () {
                if (map) {
                  openGoogleMaps(lat, lng);
                } else {
                  Get.toNamed(RouteHelper.getPdfViewerScreenRoute(url));
                  // showImageDialog(context, url);
                }
              },
              child: Text(
                value,
                style: const TextStyle(
                    fontFamily: 'Cairo', fontSize: 15, color: Colors.blue),
              )),
      ],
    );
  }
}
