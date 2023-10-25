import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_nabni_app/controller/client_controller.dart';
import 'package:new_nabni_app/data/model/user_model.dart';
import 'package:new_nabni_app/utiles/route_helper.dart';
import 'package:new_nabni_app/view/widgets/custom_button.dart';
import 'package:new_nabni_app/view/widgets/custom_snackbar.dart';
import 'package:new_nabni_app/view/widgets/custom_text_field.dart';
import 'package:permission_handler/permission_handler.dart';

class AddNewProjectScreen extends StatefulWidget {
  UserModel? contractor;
  AddNewProjectScreen({super.key, required this.contractor});

  @override
  State<AddNewProjectScreen> createState() => _AddNewProjectScreenState();
}

class _AddNewProjectScreenState extends State<AddNewProjectScreen> {
  double? lat;
  double? lng;
  TextEditingController projecdDescription = TextEditingController();
  TextEditingController projectLocation = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController design = TextEditingController();
  bool isLoading = false;

  Future<void> _getUserLocation() async {
    final PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      try {
        setState(() {
          isLoading = true;
        });
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        setState(() {
          lat = position.latitude;
          lng = position.longitude;
          projectLocation.text = 'Lat: $lat, Lng: $lng';
          isLoading = false;
        });
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        print('Error getting location: $e');
      }
    } else if (status.isDenied) {
      // Permission denied
      // You can show a message or UI to inform the user
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied
      // You can open the app settings to let the user manually enable the permission
      openAppSettings();
    }
  }

  File? fileIdentity;
  File? fileLicence;
  File? fileMap;
  var picker = ImagePicker();
  bool isImageLoading = false;

  // Future<void> getImage({forWhat}) async {
  //   isImageLoading = true;
  //   setState(() {});
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  //   if (pickedFile != null) {
  //     if (forWhat == 'identity') {
  //       setState(() {
  //         fileIdentity = File(pickedFile.path);
  //       });
  //     } else if (forWhat == 'licence') {
  //       setState(() {
  //         fileLicence = File(pickedFile.path);
  //       });
  //     } else if (forWhat == 'map') {
  //       setState(() {
  //         fileMap = File(pickedFile.path);
  //       });
  //     }
  //   }

  //   isImageLoading = false;
  //   setState(() {});
  // }

  Future<void> getFile({forWhat}) async {
    isImageLoading =
        true; // You should define isFileLoading as a boolean variable.
    setState(() {});

    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.any);

      if (result != null) {
        File file = File(result.files.single.path!);
        if (forWhat == 'identity') {
          setState(() {
            fileIdentity = File(file.path);
          });
        } else if (forWhat == 'licence') {
          setState(() {
            fileLicence = File(file.path);
          });
        } else if (forWhat == 'map') {
          setState(() {
            fileMap = File(file.path);
          });
        }
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
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Color(0xff8B7C61),
              )),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon(
              //   Icons.person_2,
              //   color: Colors.brown,
              // ),
              // SizedBox(
              //   width: 10,
              // ),
              // Text(
              //   'عبدالرحمن الغامدي',
              //   style: TextStyle(color: Colors.brown, fontFamily: 'Cairo'),
              // ),
            ],
          ),
          actions: [],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                if (isImageLoading) LinearProgressIndicator(),
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
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.home,
                          color: Color(0xff8B7C61),
                          size: 27,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'انشاء مشروع جديد',
                            style: TextStyle(
                                color: Color(0xff8B7C61),
                                fontFamily: 'Cairo',
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'مع ' + widget.contractor!.username!,
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
                    CustomTextField(
                      hintText: 'وصف المشروع',
                      controller: projecdDescription,
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
                        _getUserLocation();
                      },
                      child: CustomTextField(
                        isEnabled: false,
                        hintText: 'موقع المشروع',
                        controller: projectLocation,
                        inputType: TextInputType.text,
                        suffixIcon: IconButton(
                            onPressed: () {
                              _getUserLocation();
                            },
                            icon: const Icon(Icons.location_on_sharp)),
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
                    if (isLoading) LinearProgressIndicator(),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      hintText: 'الميزانية المقترحة',
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
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 231, 231, 231),
                            style: BorderStyle.solid,
                            width: 1),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(RouteHelper.getThreeDRoomRoute());
                      },
                      child: CustomTextField(
                        isEnabled: false,
                        hintText: 'تصميم الغرف الافتراضية',
                        controller: design,
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
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'إثبات ملكية (الصك)',
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
                        getFile(forWhat: 'identity');
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
                              child: fileIdentity == null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.file_copy,
                                          color: Theme.of(context).primaryColor,
                                          size: 40,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Text(
                                          'اختر ملف',
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
                                          child: Text("تم اختيار الملف")),
                                    ),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'رخصة البناء',
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
                        getFile(forWhat: 'licence');
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
                              child: fileLicence == null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.file_copy,
                                          color: Theme.of(context).primaryColor,
                                          size: 40,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Text(
                                          'اختر ملف',
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
                                          child: Text("تم اختيار الملف")),
                                    ),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'الخرائط',
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
                        getFile(forWhat: 'map');
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
                              child: fileMap == null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.file_copy,
                                          color: Theme.of(context).primaryColor,
                                          size: 40,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Text(
                                          'اختر ملف',
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
                                          child: Text("تم اختيار الملف")),
                                    ),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GetBuilder<ClientController>(builder: (controller) {
                      return controller.isLoading
                          ? const CircularProgressIndicator()
                          : CustomButton(
                              buttonText: 'ارسال',
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

  void _save(ClientController clientController) async {
    String _description = projecdDescription.text.trim();
    String _price = price.text.trim();

    if (_description.isEmpty) {
      showCustomSnackBar(context, 'Enter your project description!');
    } else if (lat == null && lng == null) {
      showCustomSnackBar(context, 'Please select location');
    } else if (fileIdentity == null) {
      showCustomSnackBar(context, 'Please enter identity!');
    } else if (fileLicence == null) {
      showCustomSnackBar(context, 'Please enter licence!');
    } else if (fileMap == null) {
      showCustomSnackBar(context, 'Please enter map!');
    } else {
      clientController
          .addNewProject(
            context,
            description: _description,
            price: _price,
            lat: lat,
            lng: lng,
            contractorId: widget.contractor!.id,
            fileIdentity: fileIdentity,
            fileLicence: fileLicence,
            fileMap: fileMap,
          )
          .then((status) async {});
    }
  }
}
