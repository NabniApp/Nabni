import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/controller/client_controller.dart';
import 'package:new_nabni_app/controller/contractor_controller.dart';
import 'package:new_nabni_app/data/model/invoice_model.dart';
import 'package:new_nabni_app/utiles/route_helper.dart';

class ContractorInvoicesScreen extends StatefulWidget {
  const ContractorInvoicesScreen({super.key});

  @override
  State<ContractorInvoicesScreen> createState() =>
      _ContractorInvoicesScreenState();
}

class _ContractorInvoicesScreenState extends State<ContractorInvoicesScreen> {
  @override
  void initState() {
    Get.find<ContractorController>().getContractorInvoices();
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
              GetBuilder<ContractorController>(builder: (controller) {
                return controller.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : controller.invoices.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.invoices.length,
                            itemBuilder: (context, index) {
                              return _item(controller.invoices[index]);
                            },
                          )
                        : const Center(
                            child: Text(
                            'لا يوجد فواتير',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
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
              Text(model.clientName!,
                  style: TextStyle(
                    color: Color(0xff8B7C61),
                    fontFamily: 'Cairo',
                    fontSize: 19,
                  )),
              Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit,
                    color: Colors.green,
                  ))
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
