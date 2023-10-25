import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/controller/supplier_controller.dart';
import 'package:new_nabni_app/data/model/material_model.dart';

class MaterialsHistoryScreen extends StatefulWidget {
  const MaterialsHistoryScreen({super.key});

  @override
  State<MaterialsHistoryScreen> createState() => _MaterialsHistoryScreenState();
}

class _MaterialsHistoryScreenState extends State<MaterialsHistoryScreen> {
  @override
  void initState() {
    Get.find<SupplierController>().getMaterials();
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
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xff8B7C61),
              )),
          title: Text(
            'سجل المواد',
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
                    children: [
                      Icon(
                        Icons.file_copy_outlined,
                        color: Color(0xff8B7C61),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'سجل المواد',
                        style: TextStyle(
                            color: Color(0xff8B7C61),
                            fontFamily: 'Cairo',
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                GetBuilder<SupplierController>(builder: (controller) {
                  return controller.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : controller.materials.isNotEmpty ? ListView.builder(
                        shrinkWrap: true,
                          itemCount: controller.materials.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return _item(
                                controller.materials[index], controller);
                          }) : Center(child: Text('لا يوجد مواد'));
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _item(MaterialModel model, SupplierController controller) {
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
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _rowItem('اسم المورد: ', model.username, false),
                _rowItem('وحدة المورد: ', model.supplier_unit, false),
                _rowItem('السعر: ', '${model.price} ريال', false),
              ],
            ),
            Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                model.image!,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        InkWell(
          onTap: () {
            controller.removeSubject(context, model.id);
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 100,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(5)),
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
