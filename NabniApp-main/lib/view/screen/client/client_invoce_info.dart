import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/controller/client_controller.dart';
import 'package:new_nabni_app/core/constant/appcolors.dart';
import 'package:new_nabni_app/utiles/app_constants.dart';
import 'package:new_nabni_app/utiles/preference.dart';
import 'package:new_nabni_app/utiles/route_helper.dart';
import 'package:new_nabni_app/view/widgets/custom_snackbar.dart';
import 'package:new_nabni_app/view/widgets/invoice/custom_button.dart';
import 'package:new_nabni_app/view/widgets/invoice/invoce_table_head.dart';
import 'package:new_nabni_app/view/widgets/invoice/invoce_teble.dart';
import 'package:new_nabni_app/view/widgets/invoice/line_devidor.dart';
import 'package:new_nabni_app/view/widgets/invoice/project_card.dart';

class ClientInvoceInfo extends StatefulWidget {
  final String clientName;
  final String projectId;
  final String client_id;
  final String invoice_id;
  final List items;
  final String justShow;
  final String priceWork;
  final String isConfirmedByClient;

  const ClientInvoceInfo({
    Key? key,
    required this.clientName,
    required this.projectId,
    required this.client_id,
    required this.invoice_id,
    required this.items,
    required this.priceWork,
    required this.justShow,
    required this.isConfirmedByClient,
  }) : super(key: key);

  @override
  State<ClientInvoceInfo> createState() => _ClientInvoceInfoState();
}

class _ClientInvoceInfoState extends State<ClientInvoceInfo> {
  TextEditingController priceWorkController = new TextEditingController();

  @override
  void initState() {
    if (widget.justShow == 'true') {
      priceWorkController.text = widget.priceWork.toString();
    }
    getTotalPrice();
    super.initState();
  }

  double totalPrice = 0.0; // Variable to store the total price.

  void getTotalPrice() {
    totalPrice = 0.0;

    // Calculate the total price by summing up item prices.
    for (var item in widget.items) {
      totalPrice += double.parse(item.price.toString()) *
          int.parse(item.quantity.toString());
    }

    // Check if priceWorkController has a non-empty value and add it to totalPrice.
    if (priceWorkController.text.isNotEmpty) {
      totalPrice += double.parse(priceWorkController.text);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(widget.justShow);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 254, 253, 249),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          elevation: 1,
          title: const Text('الفاتورة '),
          titleTextStyle: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
              color: Color.fromARGB(255, 139, 124, 97)),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: const Color.fromARGB(255, 139, 124, 97),
            tooltip: 'Go to the back page',
            onPressed: () {
              Get.offAndToNamed(RouteHelper.getInitialRoute());
              // Navigator.pop(context);
            },
          ),
          actions: <Widget>[],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              ProjectCard(
                titel: "فاتورة المشروع",
                subtitle: widget.clientName,
                status: widget.isConfirmedByClient == 'true'
                    ? 'تم الموافقة'
                    : 'لم تتم الموافقة',
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: const Color.fromARGB(55, 0, 0, 0),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    const InvoceTableHead(),
                    const LineDevidor(),
                    const SizedBox(height: 5),
                    InvoceTeble(items: widget.items),
                    const LineDevidor(),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          bottom: 10, right: 20, left: 20),
                      height: 50,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: priceWorkController,
                        enabled: widget.justShow == 'true' ? false : true,
                        decoration: InputDecoration(
                          prefixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(
                                Icons.money,
                                color: AppColors.primaryColor,
                                size: 30,
                              ),
                              Container(
                                width: 1,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: AppColors.gray,
                                ),
                              )
                            ],
                          ),
                          hintText: "ادخل تكلفة عملك",
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.gray,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Color(0xff15182B),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Color(0xff15182B),
                            ),
                          ),
                        ),
                        onChanged: (String? val) {
                          getTotalPrice();
                        },
                      ),
                    ),
                    const LineDevidor(),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "السعر الإجمالي  ",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "${totalPrice.toStringAsFixed(2)} ريال", // Display the total price here.
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    if (widget.justShow != 'true')
                      GetBuilder<ClientController>(builder: (controller) {
                        return controller.isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                margin: const EdgeInsets.only(bottom: 20),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: CustomIvoiceButton(
                                  buttonText: "إرسال",
                                  onPressed: () {
                                    if (priceWorkController.text.isNotEmpty) {
                                      controller.addInvoice(context,
                                          clientName: widget.clientName,
                                          client_id: widget.client_id,
                                          project_id: widget.projectId,
                                          totalPrice: totalPrice,
                                          priceWork: priceWorkController.text,
                                          items: widget.items);
                                    } else {
                                      showCustomSnackBar(
                                          context, 'ادخل تكلفة عملك');
                                    }
                                  },
                                ),
                              );
                      }),
                    if (widget.isConfirmedByClient != 'true' &&
                        Preference.shared.getString(AppConstants.USER_TYPE) ==
                            AppConstants.userTypes[2])
                      GetBuilder<ClientController>(builder: (controller) {
                        return controller.isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                margin: const EdgeInsets.only(bottom: 20),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: CustomIvoiceButton(
                                  buttonText: "الموافقة علي الفاتورة",
                                  onPressed: () {
                                    // print(widget.isConfirmedByClient);
                                    controller.agreeInvoice(context,
                                        invoice_id: widget.invoice_id);
                                  },
                                ),
                              );
                      }),
                    const SizedBox(
                      height: 10,
                    ),
                    // if (widget.isConfirmedByClient != 'true' &&
                    //     Preference.shared.getString(AppConstants.USER_TYPE) ==
                    //         AppConstants.userTypes[2])
                    //   Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       const Text(
                    //         'غير موافق علي السعر؟',
                    //         style: TextStyle(
                    //           fontSize: 14,
                    //           color: Color(0xff4c505b),
                    //         ),
                    //       ),
                    //       TextButton(
                    //         child: const Text(
                    //           'تفاوض الأن',
                    //           style: TextStyle(
                    //             decoration: TextDecoration.underline,
                    //             fontSize: 14,
                    //             color: Color(0xFF426E9B),
                    //           ),
                    //         ),
                    //         onPressed: () {

                    //         },
                    //       ),
                    //     ],
                    //   ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
