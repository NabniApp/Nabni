import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/controller/client_controller.dart';
import 'package:new_nabni_app/utiles/app_constants.dart';
import 'package:new_nabni_app/view/widgets/custom_snackbar.dart';
import 'package:new_nabni_app/view/widgets/custom_text_field.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

import '../../widgets/custom_button.dart';

const cubeSize = 200.0;
const rotationIncrement = 0.01;

class Cube3D extends StatefulWidget {
  @override
  _Cube3DState createState() => _Cube3DState();
}

class _Cube3DState extends State<Cube3D> {
  double rotationX = 0;
  double rotationY = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 254, 253, 249),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: .7,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Color(0xff8B7C61),
              )),
          title: Text(
            'الغرفة الإفتراضية',
            style: TextStyle(
                color: Color(0xff8B7C61),
                fontFamily: 'Cairo',
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
          actions: [],
        ),
        body: GetBuilder<ClientController>(builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              children: [
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.threed_rotation,
                          color: Color(0xff8B7C61),
                          size: 27,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'الغرفة الافتراضية',
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
                  height: 10,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'مساحة الغرفة: ',
                        style: TextStyle(
                            color: Color(0xff8B7C61),
                            fontFamily: 'Cairo',
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 80,
                        // height: 50,
                        child: CustomTextField(
                          hintText: 'الطول',
                          controller: controller.height,
                          inputType: TextInputType.number,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                style: BorderStyle.solid,
                                width: 10),
                          ),
                          showTitle: false,
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
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'X',
                        style: TextStyle(
                            color: Color(0xff8B7C61),
                            fontFamily: 'Cairo',
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 80,
                        // height: 50,
                        child: CustomTextField(
                          hintText: 'العرض',
                          controller: controller.width,
                          inputType: TextInputType.number,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                style: BorderStyle.solid,
                                width: 10),
                          ),
                          showTitle: false,
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
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                controller.isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        height: 80,
                        child: ListView.builder(
                          itemCount: AppConstants.materialsFor3D.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return _materialItem(controller, index,
                                AppConstants.materialsFor3D[index]);
                          },
                        ),
                      ),
                const SizedBox(
                  height: 80,
                ),
                Center(
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      setState(() {
                        // Adjust the rotation angles based on touch gestures
                        rotationX += details.delta.dy / 100;
                        rotationY += details.delta.dx / 100;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotate(vector.Vector3(1, 0, 0), rotationX)
                        ..rotate(vector.Vector3(0, 1, 0), rotationY),
                      child: CubeFaces(),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(10),
          height: 70,
          child: GetBuilder<ClientController>(builder: (controller) {
            return controller.isLoading
                ? const CircularProgressIndicator()
                : CustomButton(
                    buttonText: 'إرسال',
                    onPressed: () {
                      if (controller.height.text.isNotEmpty &&
                          controller.width.text.isNotEmpty) {
                        controller.showMaterialSummeryDialog(context);
                      } else {
                        showCustomSnackBar(
                            context, 'ادخل الطول والعرض والمواد');
                      }
                    },
                  );
          }),
        ),
      ),
    );
  }

  Widget _materialItem(ClientController controller, index, material) {
    return InkWell(
      onTap: () {
        controller.onSelectMaterial(context, material);
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200, spreadRadius: 1, blurRadius: 5)
          ],
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(material,
                  style: TextStyle(
                      color: Color(0xff8B7C61),
                      fontFamily: 'Cairo',
                      fontSize: 17,
                      fontWeight: FontWeight.bold)),
            ]),
      ),
    );
  }
}

class CubeFaces extends StatelessWidget {
  const CubeFaces();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientController>(builder: (controller) {
      List<Widget> cubeFaces;
      if (controller.selectedMaterials.isEmpty) {
        cubeFaces = [
          CubeFace(
            imageAsset: 'assets/images/tile2.jpg',
            rotation: vector.Vector3(0, 1.5708, 0),
          ),
          CubeFace(
            imageAsset: 'assets/images/tile3.jpg',
            rotation: vector.Vector3(0, -1.5708, 0),
          ),
          CubeFace(
            imageAsset: 'assets/images/tile2.jpg',
            rotation: vector.Vector3(-1.5708, 0, 0),
          ),
          CubeFace(
            imageAsset: 'assets/images/tile3.jpg',
            rotation: vector.Vector3(3.1416, 0, 0),
          ),
        ];
      } else {
        final lastMaterial = controller.selectedMaterials.last;
        cubeFaces = [
          CubeFace(
            fromNetwork: true,
            imageAsset: lastMaterial.image!,
            rotation: vector.Vector3(0, 0, 0),
          ),
          CubeFace(
            fromNetwork: true,
            imageAsset: lastMaterial.image!,
            rotation: vector.Vector3(0, 1.5708, 0),
          ),
          CubeFace(
            fromNetwork: true,
            imageAsset: lastMaterial.image!,
            rotation: vector.Vector3(0, -1.5708, 0),
          ),
          CubeFace(
            fromNetwork: true,
            imageAsset: lastMaterial.image!,
            rotation: vector.Vector3(1.5708, 0, 0),
          ),
          CubeFace(
            fromNetwork: true,
            imageAsset: lastMaterial.image!,
            rotation: vector.Vector3(-1.5708, 0, 0),
          ),
          CubeFace(
            fromNetwork: true,
            imageAsset: lastMaterial.image!,
            rotation: vector.Vector3(3.1416, 0, 0),
          ),
        ];
      }

      return Stack(
        alignment: Alignment.center,
        children: cubeFaces,
      );
    });
  }
}

class CubeFace extends StatelessWidget {
  final String imageAsset;
  final bool fromNetwork;
  final vector.Vector3 rotation;

  CubeFace(
      {required this.imageAsset,
      this.fromNetwork = false,
      required this.rotation});

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotate(rotation, rotation.length),
      alignment: FractionalOffset.center,
      child: Container(
        width: cubeSize,
        height: cubeSize,
        decoration: BoxDecoration(
          image: fromNetwork
              ? DecorationImage(
                  image: NetworkImage(
                      imageAsset), // Replace with your package name
                  fit: BoxFit.cover,
                )
              : DecorationImage(
                  image:
                      AssetImage(imageAsset), // Replace with your package name
                  fit: BoxFit.cover,
                ),
          border: Border.all(color: Colors.black, width: 2),
        ),
      ),
    );
  }
}
