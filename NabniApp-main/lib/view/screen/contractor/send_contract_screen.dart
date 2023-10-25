import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_nabni_app/controller/client_controller.dart';
import 'package:new_nabni_app/controller/contractor_controller.dart';
import 'package:new_nabni_app/data/model/user_model.dart';
import 'package:new_nabni_app/view/widgets/custom_button.dart';
import 'package:new_nabni_app/view/widgets/custom_snackbar.dart';

class SendContractScreen extends StatefulWidget {
  final String client_id;
  final String project_id;

  const SendContractScreen(
      {super.key, required this.client_id, required this.project_id});

  @override
  State<SendContractScreen> createState() => _SendContractScreenState();
}

class _SendContractScreenState extends State<SendContractScreen> {
  UserModel? model;
  @override
  void initState() {
    Get.find<ClientController>()
        .getUserData(id: widget.client_id)
        .then((value) {
      model = value;
    });
    super.initState();
  }

  File? file;
  bool isImageLoading = false;

  Future<void> getFile() async {
    isImageLoading =
        true; // You should define isFileLoading as a boolean variable.
    setState(() {});

    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.any);

      if (result != null) {
        setState(() {
          file = File(result.files.single.path!);
        });
      }
    } catch (e) {
      // Handle any errors that occurred during file picking.
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
          elevation: .7,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xff8B7C61),
              )),
          centerTitle: true,
          title: Text(
            'إرسال العقد',
            style: TextStyle(color: Color(0xff8B7C61),fontWeight: FontWeight.bold,fontSize: 17, fontFamily: 'Cairo'),
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.file_copy,
                          color: Color(0xff8B7C61),
                          size: 27,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'عقد المشروع',
                            style: TextStyle(
                                color: Color(0xff8B7C61),
                                fontFamily: 'Cairo',
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                          if (model != null)
                            Text(
                              'العميل ${model?.username}',
                              style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Cairo',
                                fontSize: 16,
                              ),
                            ),
                        ],
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
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "إرفاق ملف العقد: ",
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        )),
                    const SizedBox(
                      height: 7,
                    ),
                    GestureDetector(
                      onTap: () {
                        getFile();
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
                              child: file == null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (isImageLoading)
                                          const CircularProgressIndicator(),
                                        if (!isImageLoading)
                                          Icon(
                                            Icons.upload,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 40,
                                          ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        if (!isImageLoading)
                                          const Text(
                                            'اختر الملف',
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
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text("تم اختيار الملف"),
                                      ),
                                    ),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GetBuilder<ContractorController>(builder: (controller) {
                      return controller.isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : CustomButton(
                              buttonText: 'إرسال العقد',
                              onPressed: () {
                                if (file == null) {
                                  showCustomSnackBar(
                                      context, 'رجاءا قم برفع ملف العقد');
                                } else {
                                  controller.sendContract(context,
                                      project_id: widget.project_id,
                                      file: file);
                                }
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
}
