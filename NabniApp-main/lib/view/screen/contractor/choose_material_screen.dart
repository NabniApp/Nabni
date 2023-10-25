import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/controller/contractor_controller.dart';
import 'package:new_nabni_app/controller/supplier_controller.dart';
import 'package:new_nabni_app/data/model/material_model.dart';
import 'package:new_nabni_app/data/model/user_model.dart';
import 'package:new_nabni_app/utiles/app_constants.dart';
import 'package:new_nabni_app/utiles/route_helper.dart';
import 'package:new_nabni_app/view/widgets/custom_snackbar.dart';

class ChooseMaterialScreen extends StatefulWidget {
  final String project_id;
  final String client_id;
  final String client_name;

  const ChooseMaterialScreen({
    super.key,
    required this.project_id,
    required this.client_id,
    required this.client_name,
  });

  @override
  State<ChooseMaterialScreen> createState() => _ChooseMaterialScreenState();
}

class _ChooseMaterialScreenState extends State<ChooseMaterialScreen> {
  @override
  void initState() {
    Get.find<ContractorController>().getMaterials();
    quantityControllers
        .add(TextEditingController()); // Add the first controller
    super.initState();
  }

  @override
  void dispose() {
    // Dispose of the controllers when the widget is removed
    for (var controller in quantityControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  MaterialModel? materialSelect;
  List<MaterialModel> selectedItems = [];
  List<TextEditingController> quantityControllers = [];

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
            'اختيار المواد',
            style: TextStyle(color: Color(0xff8B7C61), fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'Cairo'),
          ),
          actions: [],
        ),
        body: SingleChildScrollView(
          child: GetBuilder<ContractorController>(builder: (controller) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    if (controller.isLoading) LinearProgressIndicator(),
                    if (!controller.isLoading &&
                        controller.materials.isNotEmpty)
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<MaterialModel>(
                            isExpanded: true,
                            hint: Row(
                              children: [
                                Icon(
                                  Icons.location_city,
                                  size: 20,
                                  color: Color(0xFF8B7C61),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                  child: Text(
                                    'نوع المادة',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF8B7C61),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            items: controller.materials
                                .map((MaterialModel item) =>
                                    DropdownMenuItem<MaterialModel>(
                                      value: item,
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        width: double.infinity,
                                        child: Text(
                                          item.username ?? '',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF8B7C61),
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: materialSelect,
                            onChanged: (value) {
                              setState(() {
                                materialSelect = value;
                              });

                              if (materialSelect != null) {
                                // Parse quantity from the last text field
                                int quantity = int.tryParse(
                                        quantityControllers.last.text) ??
                                    0;
                                // Create a new Item object and add it to the list
                                MaterialModel newItem = MaterialModel.withId(
                                    id: materialSelect?.id,
                                    subject_type: materialSelect?.username,
                                    quantity: quantity.toString(),
                                    price: materialSelect?.price,
                                    created_by: materialSelect?.created_by,
                                    supplier_unit:
                                        materialSelect?.supplier_unit);
                                setState(() {
                                  selectedItems.add(newItem);
                                  quantityControllers.add(
                                      TextEditingController()); // Add a new controller
                                });
                                // Clear the last quantity text field
                                quantityControllers.last.clear();
                              }
                            },
                            buttonStyleData: ButtonStyleData(
                              width: double
                                  .infinity, // Set the width to take up the full available width
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              decoration: BoxDecoration(
                                color: Color(0xFFFEFDF9),
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  width: 1,
                                  color: Color(0x1E15172B),
                                ),
                              ),
                              elevation: 2,
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(Icons.keyboard_arrow_down_outlined,
                                  color: Color(0xFF8B7C61)),
                            ),
                            dropdownStyleData: DropdownStyleData(
                              direction: DropdownDirection.right,
                              decoration: BoxDecoration(
                                color: Color(0xFFFEFDF9),
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  width: 1,
                                  color: Color(0x1E15172B),
                                ),
                              ),
                              scrollbarTheme: ScrollbarThemeData(
                                radius: const Radius.circular(5),
                                thickness: MaterialStateProperty.all(6),
                                thumbVisibility:
                                    MaterialStateProperty.all(true),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'المواد المضافة',
                            style: TextStyle(
                                color: Color(0xff8B7C61),
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: selectedItems.length,
                            itemBuilder: (context, index) {
                              return _item(index, selectedItems[index],
                                  quantityControllers[index], controller);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GetBuilder<ContractorController>(
                        builder: (contractorController) {
                      return contractorController.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: selectedItems.isNotEmpty
                                    ? () {
                                        _save(contractorController);
                                      }
                                    : null,
                                child: Text(
                                  'موافق',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFFFDFCF9),
                                    fontSize: 18,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(0),
                                    ),
                                  ),
                                  minimumSize: Size(300, 45),
                                  backgroundColor: Color(0xFF8B7C61),
                                ),
                              ),
                            );
                    }),
                  ]),
            );
          }),
        ),
      ),
    );
  }

  Widget _item(int index, MaterialModel item, TextEditingController _controller,
      ContractorController controller) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${index + 1}',
              style: TextStyle(color: Color(0xFF8B7C61), fontFamily: 'Cairo'),
            ),
            Text(
              item.subject_type ?? '',
              style: TextStyle(color: Color(0xFF8B7C61), fontFamily: 'Cairo'),
            ),
            Text(
              (item.price ?? '') + ' ريال',
              style: TextStyle(color: Color(0xFF8B7C61), fontFamily: 'Cairo'),
            ),
            Container(
              width: 150,
              height: 40,
              child: TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // Allow only digits
                ],
                controller: _controller,
                style: TextStyle(fontSize: 14),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(6),
                  filled: true,
                  fillColor: Color(0xFFFEFDF9),
                  hintText: 'الكمية',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Color(0x1E15172B), width: 1),
                  ),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    if (int.parse(value) >
                        int.parse(controller.materials[index].quantity!)) {
                      showCustomSnackBar(context,
                          'لا يمكنك اضافة اكتر من ${controller.materials[index].quantity!}');
                    } else {
                      setState(() {
                        selectedItems[index].quantity = value;
                      });
                    }
                  }
                },
              ),
            ),
            IconButton(
                onPressed: () {
                  _deleteItem(index);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
          ],
        ),
        Divider(),
      ],
    );
  }

  void _save(ContractorController contractorController) {
    if (selectedItems.isEmpty) {
      showCustomSnackBar(context, 'من فضلك اضف المواد!');
    } else {
      bool conditionMet = false; // Flag variable

      outerLoop:
      for (var element in contractorController.materials) {
        for (var selectedElement in selectedItems) {
          if (int.parse(selectedElement.quantity!) >
              int.parse(element.quantity!)) {
            conditionMet = true; // Set the flag to true
            break outerLoop; // Break out of both loops
          }
        }
      }

      if (conditionMet) {
        showCustomSnackBar(context, 'هناك مواد اكبر من الكمية القصوى');
      } else {
        contractorController
            .addMaterials(
          context: context,
          materials: selectedItems,
          project_id: widget.project_id,
        )
            .then((_) {
          Get.offAndToNamed(RouteHelper.getInvoiceRoute(selectedItems,
              widget.client_name, widget.client_id, widget.project_id, '0',
              isConfirmedByClient: 'false', justShow: false));
        });
      }
    }
  }

  void _deleteItem(int index) {
    setState(() {
      selectedItems.removeAt(index);
      quantityControllers.removeAt(index); // Remove the associated controller
    });
  }
}
