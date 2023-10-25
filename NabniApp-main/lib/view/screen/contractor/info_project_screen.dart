import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/utiles/app_constants.dart';
import 'package:new_nabni_app/utiles/route_helper.dart';
import 'package:new_nabni_app/view/widgets/show_image_dialog.dart';

class InfoProjectScreen extends StatefulWidget {
  const InfoProjectScreen({super.key});

  @override
  State<InfoProjectScreen> createState() => _InfoProjectScreenState();
}

class _InfoProjectScreenState extends State<InfoProjectScreen> {
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
            'مشروع #200',
            style: TextStyle(color: Color(0xff8B7C61), fontFamily: 'Cairo'),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                'assets/images/logo.jpeg',
                width: 50,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                _itemOrder('200', 'تم القبول'),
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
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(
                                    'assets/images/placeholder.jpg')),
                            const SizedBox(
                              width: 7,
                            ),
                            Text('اسم العميل: م. آحمد محسن',
                                style: TextStyle(
                                  color: Color(0xff8B7C61),
                                  fontFamily: 'Cairo',
                                  fontSize: 17,
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                Divider(),
                const SizedBox(
                  height: 20,
                ),
                Text('الموردين',
                    style: TextStyle(
                        color: Color(0xff8B7C61),
                        fontFamily: 'Cairo',
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 10,
                ),
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
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(
                                    'assets/images/placeholder.jpg')),
                            const SizedBox(
                              width: 7,
                            ),
                            Text('شركة سافيتو',
                                style: TextStyle(
                                  color: Color(0xff8B7C61),
                                  fontFamily: 'Cairo',
                                  fontSize: 19,
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 10,
                ),
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
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(
                                    'assets/images/placeholder.jpg')),
                            const SizedBox(
                              width: 7,
                            ),
                            Text('شركة الجبس الأهلية',
                                style: TextStyle(
                                  color: Color(0xff8B7C61),
                                  fontFamily: 'Cairo',
                                  fontSize: 19,
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 10,
                ),
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
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(
                                    'assets/images/placeholder.jpg')),
                            const SizedBox(
                              width: 7,
                            ),
                            Text('مصنع المنتجات العازلة',
                                style: TextStyle(
                                  color: Color(0xff8B7C61),
                                  fontFamily: 'Cairo',
                                  fontSize: 19,
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemOrder(num, status) {
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
            Text('مشروع #$num',
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
        _rowItem('حجم المشروع: ', '563 م', false),
        _rowItem('الموقع: ', 'رابط الموقع', true),
        _rowItem('الميزانية المقترحة: ', '22332 ريال', false),
        _rowItem('اثبات الملكية: ', 'اضغط هنا', true),
        _rowItem('رخصة البناء: ', 'اضغط هنا', true),
        _rowItem('الخرائط: ', 'اضغط هنا', true),
      ]),
    );
  }

  Widget _rowItem(key, value, isLink, {url, map = false, lat, lng}) {
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
              onTap: () {
                if (map) {
                  openGoogleMaps(lat, lng);
                } else {
                  // showImageDialog(context, url);
                  Get.toNamed(RouteHelper.getPdfViewerScreenRoute(url));
                }
              },
              child: Text(
                value,
                style: TextStyle(
                    fontFamily: 'Cairo', fontSize: 15, color: Colors.blue),
              )),
      ],
    );
  }
}
