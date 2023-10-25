import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/controller/client_controller.dart';
import 'package:new_nabni_app/data/model/invoice_model.dart';
import 'package:new_nabni_app/utiles/route_helper.dart';

class ClientInvoicesScreen extends StatefulWidget {
  const ClientInvoicesScreen({super.key});

  @override
  State<ClientInvoicesScreen> createState() => _ClientInvoicesScreenState();
}

class _ClientInvoicesScreenState extends State<ClientInvoicesScreen> {
  @override
  void initState() {
    Get.find<ClientController>().getClientInvoices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              GetBuilder<ClientController>(builder: (controller) {
                return controller.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : controller.invoices.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.invoices.length,
                            itemBuilder: (context, index) {
                              return _item(controller.invoices[index]);
                            },
                          )
                        : Center(
                            child: Text(
                            'لا يوجد فواتير',
                            style: TextStyle(color: Colors.black ,fontSize: 15,fontWeight: FontWeight.bold),
                          ));
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(InvoiceModel model) {
    return InkWell(
      onTap: () {
        Get.toNamed(RouteHelper.getInvoiceRoute(model.items!, model.clientName,
            model.client_id, model.project_id, model.priceWork,
            invoice_id: model.id,
            isConfirmedByClient: model.is_confirmed_by_client,
            justShow: true));
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200, spreadRadius: 1, blurRadius: 5)
          ],
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(
            children: [
              CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/placeholder.jpg')),
              const SizedBox(
                width: 7,
              ),
              Text(model.contractorName!,
                  style: TextStyle(
                    color: Colors.brown,
                    fontFamily: 'Cairo',
                    fontSize: 19,
                  )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ]),
      ),
    );
  }
}
