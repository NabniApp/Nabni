import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_nabni_app/controller/supplier_controller.dart';
import 'package:new_nabni_app/utiles/app_constants.dart';
import 'package:new_nabni_app/utiles/preference.dart';
import 'package:new_nabni_app/view/widgets/custom_button.dart';
import 'package:new_nabni_app/view/widgets/custom_snackbar.dart';
import 'package:new_nabni_app/view/widgets/custom_text_field.dart';

class AddNewMaterialScreen extends StatefulWidget {
  const AddNewMaterialScreen({super.key});

  @override
  State<AddNewMaterialScreen> createState() => _AddNewMaterialScreenState();
}

class _AddNewMaterialScreenState extends State<AddNewMaterialScreen> {
  bool loading = false;

  TextEditingController nameSupplier = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController price = TextEditingController();
  String? selectedSupplierUnit;
  String? selectedSubjectType;
  File? image;
  var picker = ImagePicker();
  bool isImageLoading = false;
  Future<void> getImage() async {
    isImageLoading = true;
    setState(() {});
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
    }

    isImageLoading = false;
    setState(() {});
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
            'إضافة مادة جديدة',
            style: TextStyle(color: Color(0xff8B7C61), fontWeight: FontWeight.bold, fontSize: 17,fontFamily: 'Cairo'),
          ),
          actions: [],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).cardColor,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade200,
                          spreadRadius: 1,
                          blurRadius: 5)
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.home,
                        color: Color(0xff8B7C61),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'اضافة مادة جديدة',
                        style: TextStyle(
                            color: Color(0xff8B7C61),
                            fontFamily: 'Cairo',
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).cardColor,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade200,
                          spreadRadius: 1,
                          blurRadius: 5)
                    ],
                  ),
                  child: Column(children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "وحدة المادة",
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            )),
                        const SizedBox(
                          height: 7,
                        ),
                        Container(
                          width: double.infinity, // Expand to full width
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 231, 231, 231),
                                style: BorderStyle.solid,
                                width: 1),
                            borderRadius:
                                BorderRadius.circular(8), // Add border radius
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12),

                          child: DropdownButton(
                            value: selectedSupplierUnit,
                            onChanged: (newValue) {
                              setState(() {
                                selectedSupplierUnit = newValue;
                              });
                            },
                            underline: Container(
                              height: 0,
                              color: Colors.transparent,
                            ),
                            isExpanded: true,
                            items: [
                              DropdownMenuItem(
                                  alignment: Alignment.centerRight,
                                  child: Text('متر'),
                                  value: 'متر'),
                              DropdownMenuItem(
                                  alignment: Alignment.centerRight,
                                  child: Text('طن'),
                                  value: 'طن'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "نوع المادة",
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            )),
                        const SizedBox(
                          height: 7,
                        ),
                        Container(
                          width: double.infinity, // Expand to full width
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 231, 231, 231),
                                style: BorderStyle.solid,
                                width: 1),
                            borderRadius:
                                BorderRadius.circular(8), // Add border radius
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: DropdownButton(
                            value:
                                selectedSubjectType, // Set the initial value to null or a valid initial value
                            onChanged: (newValue) {
                              setState(() {
                                selectedSubjectType = newValue;
                              });
                            },
                            underline: Container(
                              height: 0,
                              color: Colors.transparent,
                            ),
                            isExpanded: true,
                            items: const [
                              DropdownMenuItem(
                                  alignment: Alignment.centerRight,
                                  child: Text('بلاط'),
                                  value: 'بلاط'),
                              DropdownMenuItem(
                                  alignment: Alignment.centerRight,
                                  child: Text('بويه'),
                                  value: 'بويه'),
                              DropdownMenuItem(
                                  alignment: Alignment.centerRight,
                                  child: Text('حديد'),
                                  value: 'حديد'),
                              DropdownMenuItem(
                                  alignment: Alignment.centerRight,
                                  child: Text('طوب'),
                                  value: 'طوب'),
                              DropdownMenuItem(
                                  alignment: Alignment.centerRight,
                                  child: Text('اسمنت'),
                                  value: 'اسمنت'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      hintText: 'اسم المورد',
                      controller: nameSupplier,
                      inputType: TextInputType.text,
                      showTitle: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            style: BorderStyle.solid,
                            width: 10),
                      ),
                      activeBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            style: BorderStyle.solid,
                            width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 231, 231, 231),
                            style: BorderStyle.solid,
                            width: 1),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      hintText: 'الكمية القصوي',
                      controller: quantity,
                      inputType: TextInputType.number,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            style: BorderStyle.solid,
                            width: 10),
                      ),
                      activeBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            style: BorderStyle.solid,
                            width: 2),
                      ),
                      showTitle: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 231, 231, 231),
                            style: BorderStyle.solid,
                            width: 1),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      hintText: 'السعر',
                      controller: price,
                      inputType: TextInputType.number,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            style: BorderStyle.solid,
                            width: 10),
                      ),
                      showTitle: true,
                      activeBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            style: BorderStyle.solid,
                            width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 231, 231, 231),
                            style: BorderStyle.solid,
                            width: 1),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "ارفاق صورة",
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        )),
                    const SizedBox(
                      height: 7,
                    ),
                    GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 5.0),
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(10),
                            dashPattern: const [7, 4],
                            strokeCap: StrokeCap.round,
                            color: Theme.of(context).primaryColor,
                            child: Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                  color: Colors.blue.shade50.withOpacity(.3),
                                  borderRadius: BorderRadius.circular(10)),
                              child: image == null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (isImageLoading)
                                          const CircularProgressIndicator(),
                                        if (!isImageLoading)
                                          Icon(
                                            Icons.image,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 40,
                                          ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        if (!isImageLoading)
                                          const Text(
                                            'اختر صورة',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey,
                                                fontFamily: 'Cairo'),
                                          ),
                                      ],
                                    )
                                  : Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: FileImage(
                                            image!,
                                          ),
                                          fit: BoxFit.cover,
                                          colorFilter: ColorFilter.mode(
                                              Colors.black.withOpacity(0.4),
                                              BlendMode.darken),
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    GetBuilder<SupplierController>(builder: (controller) {
                      return loading
                          ? CircularProgressIndicator()
                          : CustomButton(
                              buttonText: 'إضافة',
                              onPressed: () {
                                _save(controller);
                              },
                            );
                    }),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _save(SupplierController controller) async {
    Preference storage = Preference.shared;

    String _username = nameSupplier.text.trim();
    String _quantity = quantity.text.trim();
    String _price = price.text.trim();

    if (_username.isEmpty) {
      showCustomSnackBar(context, 'الرجاء إدخال اسم المورد');
    } else if (_quantity.isEmpty) {
      showCustomSnackBar(context, 'الرجاء إدخال الكمية القصوى');
    } else if (_price.isEmpty) {
      showCustomSnackBar(context, 'الرجاء إدخال السعر');
    } else if (selectedSubjectType == null) {
      showCustomSnackBar(context, 'الرجاء إدخال نوع المادة');
    } else if (selectedSupplierUnit == null) {
      showCustomSnackBar(context, 'الرجاء إدخال وحدة المادة');
    } else if (image == null) {
      showCustomSnackBar(context, 'الرجاء إدراج صورة للمادة');
    } else {
      setState(() {
        loading = true;
      });
      await controller.uploadImage(image!).then((image_url) async {
        controller
            .addNewSubject(context,
                username: _username,
                quantity: _quantity,
                price: _price,
                date: DateTime.now().toIso8601String(),
                subject_type: selectedSubjectType,
                supplier_unit: selectedSupplierUnit,
                image: image_url,
                created_by: storage.getString(AppConstants.USER_ID))
            .then((value2) {});

        setState(() {
          loading = false;
        });
      });
    }
  }
}
