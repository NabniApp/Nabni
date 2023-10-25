import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_nabni_app/controller/contractor_controller.dart';
import 'package:new_nabni_app/view/widgets/custom_button.dart';
import 'package:new_nabni_app/view/widgets/custom_snackbar.dart';
import 'package:new_nabni_app/view/widgets/custom_text_field.dart';

class AddNewWorkScreen extends StatefulWidget {
  const AddNewWorkScreen({super.key});

  @override
  State<AddNewWorkScreen> createState() => _AddNewWorkScreenState();
}

class _AddNewWorkScreenState extends State<AddNewWorkScreen> {
  TextEditingController projectName = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController projectSpace = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();

  bool isImageLoading = false;

  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  Future<void> loadAssets() async {
    isImageLoading = true;
    setState(() {});

    try {
      final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
      if (selectedImages!.isNotEmpty) {
        imageFileList!.addAll(selectedImages);
      }
    } on Exception catch (e) {
      print(e.toString());
    }

    if (!mounted) return;

    imageController.text =
        "تم اختيار " + imageFileList!.length.toString() + 'صور';
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
          elevation: .7,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Color(0xff8B7C61),
              )),
          centerTitle: true,
          title: const Text(
            'اضافة عمل سابق',
            style: TextStyle(color: Color(0xff8B7C61), fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'Cairo'),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.list,
                        color: Color(0xff8B7C61),
                        size: 27,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'إضافة عمل سابق',
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
                    CustomTextField(
                      hintText: 'اسم المشروع',
                      controller: projectName,
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
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 231, 231, 231),
                            style: BorderStyle.solid,
                            width: 1),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        loadAssets();
                      },
                      child: CustomTextField(
                        hintText: 'صور للمشروع',
                        isEnabled: false,
                        controller: imageController,
                        inputType: TextInputType.text,
                        suffixIcon: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.add)),
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
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 231, 231, 231),
                              style: BorderStyle.solid,
                              width: 1),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      hintText: 'مساحة المشروع (متر)',
                      controller: projectSpace,
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
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 231, 231, 231),
                            style: BorderStyle.solid,
                            width: 1),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      hintText: 'ميزانية المشروع',
                      controller: price,
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
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 231, 231, 231),
                            style: BorderStyle.solid,
                            width: 1),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextField(
                      hintText: 'الوصف',
                      controller: description,
                      inputType: TextInputType.multiline,
                      maxLines: 5,
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
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 231, 231, 231),
                            style: BorderStyle.solid,
                            width: 1),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GetBuilder<ContractorController>(builder: (controller) {
                      return controller.isLoading
                          ? CircularProgressIndicator()
                          : 
                          CustomButton(
                              buttonText: 'إضافة مشروع',
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

  void _save(ContractorController controller) async {
    String _description = description.text.trim();
    String _name = projectName.text.trim();
    String _price = price.text.trim();
    String _space = projectSpace.text.trim();

    if (_description.isEmpty) {
      showCustomSnackBar(context, 'الرجاء إدخال وصف المشروع');
    } else if (_name.isEmpty) {
      showCustomSnackBar(context, 'الرجاء إدخال اسم المشروع');
    } else if (_price.isEmpty) {
      showCustomSnackBar(context, 'الرجاء إدخال ميزانية المشروع');
    } else if (_space.isEmpty) {
      showCustomSnackBar(context, 'الرجاء إدخال مساحة المشروع');
    } else {
      List<File> imageFiles = imageFileList!.map((XFile xFile) {
        return File(xFile.path);
      }).toList();
      controller
          .addNewWork(context,
              description: _description,
              name: _name,
              space: _space,
              price: _price,
              images: imageFiles)
          .then((status) async {});
    }
  }
}
