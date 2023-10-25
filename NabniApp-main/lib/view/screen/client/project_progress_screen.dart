import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/controller/client_controller.dart';
import 'package:new_nabni_app/data/model/step_model.dart';

class ProjectProgressScreen extends StatefulWidget {
  final String projectId;
  const ProjectProgressScreen({super.key, required this.projectId});

  @override
  State<ProjectProgressScreen> createState() => _ProjectProgressScreenState();
}

class _ProjectProgressScreenState extends State<ProjectProgressScreen> {
  @override
  void initState() {
    Get.find<ClientController>().getProjectSteps(widget.projectId);
    super.initState();
  }

  String getDate(Timestamp timestamp) {
    // Convert the Timestamp to a DateTime
    DateTime dateTime = timestamp.toDate();

// Format the DateTime to get just the date as a string (in the format 'yyyy-MM-dd')
    String date =
        "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";

    return date;
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
            'الجدول الزمني للمشروع',
            style: TextStyle(color: Color(0xff8B7C61), fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'Cairo'),
          ),
          actions: [],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        Icons.list,
                        color: Color(0xff8B7C61),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'الجدول الزمني للمشروع',
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
                GetBuilder<ClientController>(builder: (controller) {
                  return controller.isLoading
                      ? CircularProgressIndicator()
                      : controller.projectSteps.isNotEmpty
                          ? ListView.builder(
                              itemCount: controller.projectSteps.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return _item(controller.projectSteps[index]);
                              },
                            )
                          : Text('لم يتم إضافة خطوة',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold));
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _item(StepModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: 10,
        ),
        Container(
          color: Color(0xff8B7C61),
          width: 3,
          height: 200,
        ),
        const SizedBox(
          width: 30,
        ),
        Expanded(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
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
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Icon(
                              Icons.home,
                              size: 30,
                              color: Color(0xff8B7C61),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  model.step_name!,
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Cairo'),
                                ),
                                Text(
                                  'تاريخ البدء: ${getDate(model.startDate!)}',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Cairo'),
                                ),
                                Text(
                                  'تاريخ الإنتهاء المتوقع: ${getDate(model.endDate!)}',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Cairo'),
                                ),
                              ],
                            ),
                          ),
                          VerticalDivider(
                            width: 2.0,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        model.description!,
                        style: TextStyle(fontSize: 16.0, fontFamily: 'Cairo'),
                      ),
                    ]),
              ),
              Positioned(
                  right: -38,
                  top: 80,
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
