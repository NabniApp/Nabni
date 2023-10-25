import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/controller/contractor_controller.dart';
import 'package:new_nabni_app/data/model/review_model.dart';

class ReviewClientScreen extends StatefulWidget {
  const ReviewClientScreen({super.key});

  @override
  State<ReviewClientScreen> createState() => _ReviewClientScreenState();
}

class _ReviewClientScreenState extends State<ReviewClientScreen> {
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
                color: Colors.brown,
              )),
          title: Text(
            'تقييم العملاء',
            style: TextStyle(color: Colors.brown, fontFamily: 'Cairo'),
          ),
          actions: [],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                GetBuilder<ContractorController>(builder: (controller) {
                  return controller.isLoading
                      ? CircularProgressIndicator()
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.reviews.length,
                          itemBuilder: (context, index) {
                            return _item(controller.reviews[index]);
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

  Widget _item(ReviewModel model) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, spreadRadius: 1, blurRadius: 5)
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/placeholder.jpg')),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.client_name ?? '',
                style: TextStyle(
                    color: Colors.brown,
                    fontFamily: 'Cairo',
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(int.parse(model.stars.toString()),
                    (index) => Icon(Icons.star, color: Colors.amber, size: 27)),
              ),
              Text(
                model.content ?? '',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ],
      ),
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
