import 'package:flutter/material.dart';

class SingleProjectScreen extends StatefulWidget {
  const SingleProjectScreen({super.key});

  @override
  State<SingleProjectScreen> createState() => _SingleProjectScreenState();
}

class _SingleProjectScreenState extends State<SingleProjectScreen> {
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
                            Icon(
                              Icons.person,
                              color: Color(0xff8B7C61),
                              size: 30,
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Text('اسم المقاول: م. آحمد محسن',
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
        const SizedBox(
          height: 10,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('تم القبول',
                style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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

}
