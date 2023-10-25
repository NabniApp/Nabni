import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/controller/contractor_controller.dart';
import 'package:new_nabni_app/data/model/project_model.dart';
import 'package:new_nabni_app/utiles/app_constants.dart';
import 'package:new_nabni_app/utiles/route_helper.dart';
import 'package:new_nabni_app/view/widgets/custom_button.dart';
import 'package:new_nabni_app/view/widgets/show_image_dialog.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  @override
  void initState() {
    Get.find<ContractorController>().getProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<ContractorController>(builder: (controller) {
        return controller.isLoading
            ? Center(child: const CircularProgressIndicator())
            : SizedBox(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.projects.length,
                  itemBuilder: (context, index) {
                    return _item(
                        index + 1, controller.projects[index], controller);
                  },
                ),
              );
      }),
    );
  }

  Widget _item(index, ProjectModel model, ContractorController controller) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        border: Border.all(
          color: const Color.fromARGB(255, 240, 240, 240),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.home,
                size: 25,
                color: Color.fromARGB(255, 139, 124, 97),
              ),
              Text(
                '  مشروع $index',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff8B7C61),
                  fontFamily: 'Cairo',
                ),
              ),
              Spacer(),
              if (model.status == 'rejected')
                Container(
                  height: 35, // ارتفاع مربع الرفض
                  child: ElevatedButton(
                    onPressed: () {
                      print('test');
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(
                          255, 212, 81, 81), // لون خلفية مربع الرفض
                    ),
                    child: Text(
                      'تم الرفض',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                        color: Color.fromARGB(255, 255, 255, 255), // لون الخط
                      ),
                    ),
                  ),
                ),
              if (model.status == 'in_deal')
                Container(
                  height: 35, // ارتفاع مربع التفاوض
                  child: ElevatedButton(
                    onPressed: () {
                      print(model.client_id);
                      controller.updateStatus(
                          context, model.id, model.client_id, 'done_deal');

                      // Get.toNamed(
                      //     RouteHelper.getChatScreenRoute(model.client_id!));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(
                          255, 65, 188, 106), // لون خلفية مربع التفاوض
                    ),
                    child: Text(
                      'اضغط لاتمام المشروع',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                        color: Color.fromARGB(255, 255, 255, 255), // لون الخط
                      ),
                    ),
                  ),
                ),
              if (model.status == 'done_deal')
                Container(
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () {
                      print(model.client_id);
                      // Get.toNamed(
                      //     RouteHelper.getChatScreenRoute(model.client_id!));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(
                          255, 65, 188, 106), // لون خلفية مربع التفاوض
                    ),
                    child: Text(
                      'تم الاتفاق',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                        color: Color.fromARGB(255, 255, 255, 255), // لون الخط
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'حجم المشروع : ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                  color: Colors.black, // تغيير لون النص إلى الأسود هنا
                ),
              ),
              Text(
                '324م',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Cairo',
                  color: Color.fromARGB(
                      255, 0, 0, 0), // تغيير لون القيمة إلى الأزرق هنا
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'الموقع : ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                  color: Colors.black, // تغيير لون النص إلى الأسود هنا
                ),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  'رابط الموقع',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Cairo',
                    color: Colors.blue, // تغيير لون القيمة إلى الأزرق هنا
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '  الميزانية المقترحة : ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                  color: Colors.black, // تغيير لون النص إلى الأسود هنا
                ),
              ),
              Text(
                '${model.price} ريال',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Cairo',
                  color: const Color.fromARGB(
                      255, 0, 0, 0), // تغيير لون القيمة إلى الأزرق هنا
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                ' إثبات الملكية : ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                  color: Colors.black, // تغيير لون النص إلى الأسود هنا
                ),
              ),
              InkWell(
                onTap: () {
                  // showImageDialog(context, model.imageIdentity!);
                  Get.toNamed(RouteHelper.getPdfViewerScreenRoute(
                      model.imageIdentity!));
                },
                child: Text(
                  'اضغط هنا',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Cairo',
                    color: Colors.blue, // تغيير لون القيمة إلى الأزرق هنا
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'رخصة البناء : ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                  color: Colors.black, // تغيير لون النص إلى الأسود هنا
                ),
              ),
              InkWell(
                onTap: () {
                  // showImageDialog(context, model.imageLicence!);
                  Get.toNamed(
                      RouteHelper.getPdfViewerScreenRoute(model.imageLicence!));
                },
                child: Text(
                  'اضغط هنا',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Cairo',
                    color: Colors.blue, // تغيير لون القيمة إلى الأزرق هنا
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'الخرائط : ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                  color: Colors.black, // تغيير لون النص إلى الأسود هنا
                ),
              ),
              InkWell(
                onTap: () {
                  print('object');
                  // showImageDialog(context, model.imageMap!);
                  Get.toNamed(
                      RouteHelper.getPdfViewerScreenRoute(model.imageMap!));
                },
                child: Text(
                  'اضغط هنا',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Cairo',
                    color: Colors.blue, // تغيير لون القيمة إلى الأزرق هنا
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'متطلبات الغرفة الافتراضية : ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                  color: Colors.black, // تغيير لون النص إلى الأسود هنا
                ),
              ),
              InkWell(
                onTap: () {
                  showMaterialSummeryDialog(
                      context, model.materials, model.width, model.height);
                },
                child: Text(
                  'اضغط هنا',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Cairo',
                    color: Colors.blue, // تغيير لون القيمة إلى الأزرق هنا
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          if (model.status == 'under_review')
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 80, // عرض مربع التفاوض
                  height: 35, // ارتفاع مربع التفاوض
                  child: ElevatedButton(
                    onPressed: () {
                      controller.updateStatus(
                          context, model.id, model.client_id, 'in_deal');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CometChatConversationsWithMessages(
                            conversationsConfiguration:
                                ConversationsConfiguration(
                                    backButton: IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.black,
                                        ))),
                            user: User(
                                uid: model.client_id!, name: 'تفاوض مع العميل'),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(
                          255, 65, 188, 106), // لون خلفية مربع التفاوض
                    ),
                    child: Text(
                      'تفاوض',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                        color: Color.fromARGB(255, 255, 255, 255), // لون الخط
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Container(
                  width: 80, // عرض مربع الرفض
                  height: 35, // ارتفاع مربع الرفض
                  child: ElevatedButton(
                    onPressed: () {
                      controller.updateStatus(
                          context, model.id, model.client_id, 'rejected');
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(
                          255, 212, 81, 81), // لون خلفية مربع الرفض
                    ),
                    child: Text(
                      'رفض',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                        color: Color.fromARGB(255, 255, 255, 255), // لون الخط
                      ),
                    ),
                  ),
                ),
              ],
            ),
          if (model.status == 'done_deal')
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(
                          RouteHelper.getAddNewStepScreenRoute(model.id!));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(
                          255, 65, 188, 106), // لون خلفية مربع التفاوض
                    ),
                    child: Text(
                      'اضافة خطوة',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                        color: Color.fromARGB(255, 255, 255, 255), // لون الخط
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                if (model.materialSelected != 'null')
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (!model.materialSelected) {
                          Get.toNamed(RouteHelper.getChooseMaterialRoute(
                              model.id!, 'اسم العميل', model.client_id!));
                        } else {
                          controller
                              .getInvoiceData(model.id!, model.client_id!)
                              .then((data) {
                            if (data != 'errors' && data.isNotEmpty) {
                              // Get.toNamed(RouteHelper.getInvoiceRoute(
                              //     data['materialItems'],
                              //     'اسم العميل',
                              //     model.client_id,
                              //     model.id,
                              //     data['priceWork'],
                              //     justShow: true,
                              //     isConfirmedByClient:
                              //         data['is_confirmed_by_client']));

                              Get.toNamed(RouteHelper.getEditInvoiceRoute(
                                  data['materialItems'],
                                  'اسم العميل',
                                  model.client_id,
                                  model.id,
                                  data['priceWork'],
                                  isConfirmedByClient:
                                      data['is_confirmed_by_client'],
                                  invoice_id: data['invoice_id']));
                            }
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.amber, // لون خلفية مربع التفاوض
                      ),
                      child: Text(
                        (!model.materialSelected)
                            ? 'اختيار المواد'
                            : 'تعديل الفاتورة',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                          color: Color.fromARGB(255, 255, 255, 255), // لون الخط
                        ),
                      ),
                    ),
                  ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      controller.updateStatus(
                          context, model.id, model.client_id, 'finished');
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(
                          255, 212, 81, 81), // لون خلفية مربع الرفض
                    ),
                    child: Text(
                      'إنهاء المشروع',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                        color: Color.fromARGB(255, 255, 255, 255), // لون الخط
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  double calculateTotalPrice(width, height, materials) {
    double total = 0.0;
    print(materials);
    for (final order in materials) {
      final itemPrice = double.parse(order.price!);
      final totalPriceForItem =
          itemPrice * (double.parse(width) * double.parse(height));
      total += totalPriceForItem;
    }

    return total;
  }

  showMaterialSummeryDialog(
      BuildContext context, materials, width, height) async {
    final total = calculateTotalPrice(width, height, materials);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      'طلبات الغرفة الافتراضية',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo'),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 150,
                    child: ListView.builder(
                      itemCount: materials.length,
                      itemBuilder: (context, index) {
                        final order = materials[index];

                        return Card(
                          child: Row(
                            children: [
                              Text((index + 1).toString()),
                              Spacer(),
                              Text(order.subject_type!),
                              Spacer(),
                              SizedBox(width: 10),
                              Text('${order.price} ريال'),
                              Spacer(),
                              Text(
                                  '${int.parse(order.price!) * int.parse(width)} ريال'),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'المساحة',
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo'),
                      ),
                      Text(
                        "${width}x${height}",
                        style:
                            const TextStyle(fontSize: 15, fontFamily: 'Cairo'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'السعر التقريبي',
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo'),
                      ),
                      Text(
                        "${total.toStringAsFixed(2)} ريال",
                        style:
                            const TextStyle(fontSize: 15, fontFamily: 'Cairo'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    margin: const EdgeInsets.all(10.0),
                    buttonText: 'تم',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
