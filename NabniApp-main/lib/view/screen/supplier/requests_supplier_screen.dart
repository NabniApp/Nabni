import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/controller/supplier_controller.dart';
import 'package:new_nabni_app/data/model/material_model.dart';

class RequestsSupplierScreen extends StatefulWidget {
  const RequestsSupplierScreen({super.key});

  @override
  State<RequestsSupplierScreen> createState() => _RequestsSupplierScreenState();
}

class _RequestsSupplierScreenState extends State<RequestsSupplierScreen> {
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
            ? Center(child: CircularProgressIndicator())
            : controller.requests.isNotEmpty
                ? ListView.builder(
                    itemCount: controller.requests.length,
                    itemBuilder: (context, index) {
                      return _itemBuilder(
                          controller.requests[index], controller);
                    },
                  )
                : Text("لا توجد طلبات");
      }),
    );
  }

  _itemBuilder(MaterialModel model, SupplierController controller) {
    return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          border: Border.all(
            color: const Color.fromARGB(255, 240, 240, 240),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    backgroundImage:
                        AssetImage('assets/images/placeholder.png')),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  model.username ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Cairo',
                  ),
                ),
                Spacer(),
                if (!model.isAcceptedBySupplier!)
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
                        'لم تتم الموافقة',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                          color: Color.fromARGB(255, 255, 255, 255), // لون الخط
                        ),
                      ),
                    ),
                  ),
                if (model.isAcceptedBySupplier!)
                  Container(
                    height: 35, // ارتفاع مربع التفاوض
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(
                            255, 65, 188, 106), // لون خلفية مربع التفاوض
                      ),
                      child: Text(
                        'تمت الموافقة',
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
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  model.subject_type ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff8B7C61),
                    fontFamily: 'Cairo',
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: Text(
                    model.quantity!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                      color: Color.fromARGB(255, 156, 156, 156), // لون الخط
                    ),
                  ),
                ),
                SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: Text(
                    model.supplier_unit ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                      color: Color.fromARGB(255, 156, 156, 156), // لون الخط
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                // Action to perform when the negotiation button is pressed
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 255, 255, 255),
              ),
              child: Row(
                children: [
                  Text(
                    'السعر بالمتر  : ',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '${model.price ?? ''} ريال',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Cairo',
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  Text(
                    '              السعر الاجمالي : ',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    (int.parse(model.price ?? '0') * int.parse(model.quantity!))
                            .toString() +
                        ' ريال',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Cairo',
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!model.isAcceptedBySupplier!)
                  ElevatedButton(
                    onPressed: () {
                      controller.updateRequestStatus(
                          context,
                          model.project_id!,
                          model.client_id!,
                          model.id!,
                          model.subject_type!,
                          model.quantity!);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green, // لون خلفية مربع
                    ),
                    child: Text(
                      'الموافقة',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                        color: Color.fromARGB(255, 255, 255, 255), // لون الخط
                      ),
                    ),
                  ),
                ElevatedButton(
                  onPressed: () {
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
                              uid: model.contractor_id!,
                              name: 'تفاوض مع المقاول'),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary:
                        Color.fromARGB(255, 139, 124, 97), // لون خلفية مربع
                  ),
                  child: Text(
                    'الذهاب للمحادثة',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                      color: Color.fromARGB(255, 255, 255, 255), // لون الخط
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
