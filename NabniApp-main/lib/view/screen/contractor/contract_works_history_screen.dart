import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/controller/contractor_controller.dart';
import 'package:new_nabni_app/data/model/my_project_model.dart';
import 'package:new_nabni_app/utiles/route_helper.dart';

class ContractWorksHistoryScreen extends StatefulWidget {
  const ContractWorksHistoryScreen({super.key});

  @override
  State<ContractWorksHistoryScreen> createState() =>
      _ContractWorksHistoryScreenState();
}

class _ContractWorksHistoryScreenState
    extends State<ContractWorksHistoryScreen> {
  @override
  void initState() {
    Get.find<ContractorController>().getMyProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController review = TextEditingController();

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
              icon: Icon(Icons.arrow_back_ios,color: Color(0xff8B7C61))),
          title: Text(
            'سجل الأعمال',
            style: TextStyle(color: Color(0xff8B7C61),fontWeight: FontWeight.bold, fontSize: 17, fontFamily: 'Cairo'),
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
                        Icons.file_copy_outlined,
                        color: Color(0xff8B7C61),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'سجل الأعمال',
                        style: TextStyle(
                            color: Color(0xff8B7C61),
                            fontFamily: 'Cairo',
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Get.toNamed(RouteHelper.getAddNewWorkRoute());
                        },
                        child: Container(
                          width: 100,
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            'إضافة',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Cairo',
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GetBuilder<ContractorController>(builder: (controller) {
                  return controller.isLoading
                      ? const CircularProgressIndicator()
                      : controller.myProjects.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.myProjects.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return _item(
                                    controller.myProjects[index], controller);
                              },
                            )
                          : Center(child: Text('لا يوجد مشاريع',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)));
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _item(MyProjectModel model, ContractorController controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, spreadRadius: 1, blurRadius: 5)
        ],
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.home,
                      color: Color(0xFF8B7C61),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      model.name!,
                      style: TextStyle(
                          color: Color(0xFF8B7C61),
                          fontFamily: 'Cairo',
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                _rowItem('حجم المشروع : ', model.space, false),
                _rowItem('ميزانية المشروع: ', model.price, false),
              ],
            ),
            Spacer(),
            Container(
              width: 150,
              height: 150,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 3),
                itemCount: model.images
                    ?.length, // Total number of items (2 rows x 2 columns = 4 items)
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      model.images![index],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        InkWell(
          onTap: () {
            controller.removeProject(context, model.id);
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: controller.isLoading
                ? CircularProgressIndicator()
                : Container(
                    width: 100,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      'حذف',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Cairo',
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
          ),
        )
      ]),
    );
  }

  Widget _rowItem(key, value, isLink) {
    return Row(
      children: [
        Text(key,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 16,
            )),
        const SizedBox(
          width: 7,
        ),
        if (!isLink)
          Text(value, style: TextStyle(fontFamily: 'Cairo', fontSize: 14)),
        if (isLink)
          InkWell(
              onTap: () {},
              child: Text(
                value,
                style: TextStyle(
                    fontFamily: 'Cairo', fontSize: 15, color: Colors.blue),
              )),
      ],
    );
  }
}
