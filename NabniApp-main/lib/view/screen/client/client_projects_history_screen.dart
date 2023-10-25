import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/controller/client_controller.dart';
import 'package:new_nabni_app/data/model/project_model.dart';

class ClientProjectHistoryScreen extends StatefulWidget {
  const ClientProjectHistoryScreen({super.key});

  @override
  State<ClientProjectHistoryScreen> createState() =>
      _ClientProjectHistoryScreenState();
}

class _ClientProjectHistoryScreenState
    extends State<ClientProjectHistoryScreen> {
  @override
  void initState() {
    Get.find<ClientController>().getProjects();

    // TODO: implement initState
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
            'سجل المشاريع',
            style: TextStyle(color: Color(0xff8B7C61),fontWeight: FontWeight.bold, fontSize: 18, fontFamily: 'Cairo'),
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
                        'سجل المشاريع',
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
                  height: 25,
                ),
                GetBuilder<ClientController>(builder: (controller) {
                  return controller.isLoading
                      ? CircularProgressIndicator()
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.projects.length,
                          itemBuilder: (context, index) {
                            return _item(index, controller.projects[index]);
                          },
                        );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _item(index, ProjectModel model) {
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
            Icon(
              Icons.home,
              color: Color(0xff8B7C61),
              size: 25,
            ),
            const SizedBox(
              width: 7,
            ),
            Text('مشروع #$index',
                style: TextStyle(
                    color: Color(0xff8B7C61),
                    fontFamily: 'Cairo',
                    fontSize: 17,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        _rowItem('اسم المقاول: ', model.contractor_name, false),
        _rowItem('مدة التنفيذ: ', 'جاري التنفيذ', false),
        const SizedBox(
          height: 10,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('حالة الطلب: ${typeStatus(model.status)}',
                style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16,
                    //fontWeight: FontWeight.bold,
                    color: Color(0xff8B7C61)))),
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

  String? typeStatus(status) {
    String _status = 'جاري التنفيذ';
    if (status == 'finished') {
      _status = 'تم الإنتهاء';
    } else if (status == 'rejected') {
      _status = 'تم الرفض';
    } else if (status == 'under_review') {
      _status = 'تحت المراجعة';
    } else if (status == 'done_deal') {
      _status = 'تمت الموافقة';
    }

    return _status;
  }

}
