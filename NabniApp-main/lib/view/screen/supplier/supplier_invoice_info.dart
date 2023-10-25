import 'package:flutter/material.dart';
import 'package:new_nabni_app/core/constant/appcolors.dart';
import 'package:new_nabni_app/view/widgets/invoice/invoce_table_head.dart';
import 'package:new_nabni_app/view/widgets/invoice/invoce_teble.dart';
import 'package:new_nabni_app/view/widgets/invoice/line_devidor.dart';
import 'package:new_nabni_app/view/widgets/invoice/project_card.dart';

class SupplierInvoiceInfo extends StatefulWidget {
  final String clientName;
  final String invoice_id;
  final List items;

  const SupplierInvoiceInfo({
    Key? key,
    required this.clientName,
    required this.invoice_id,
    required this.items,
  }) : super(key: key);

  @override
  State<SupplierInvoiceInfo> createState() => _SupplierInvoiceInfoState();
}

class _SupplierInvoiceInfoState extends State<SupplierInvoiceInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0.0; // Variable to store the total price.

    // Calculate the total price by summing up item prices.
    for (var item in widget.items) {
      print(item);
      totalPrice += double.parse(item.price) * int.parse(item.quantity);
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 254, 253, 249),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          elevation: 1,
          title: const Text('الفاتورة '),
          titleTextStyle: const TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
              color: Color.fromARGB(255, 139, 124, 97)),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: const Color.fromARGB(255, 139, 124, 97),
            tooltip: 'Go to the back page',
            onPressed: () {
              // Get.offAndToNamed(RouteHelper.getInitialRoute());
              Navigator.pop(context);
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
                titel: "فاتورة",
                subtitle: widget.clientName,
                status: '',
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
                    const LineDevidor(),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "السعر الاجمالي  ",
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
