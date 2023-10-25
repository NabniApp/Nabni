import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/controller/supplier_controller.dart';
import 'package:new_nabni_app/data/model/user_model.dart';
import 'package:new_nabni_app/utiles/app_constants.dart';
import 'package:new_nabni_app/utiles/route_helper.dart';
import 'package:new_nabni_app/view/widgets/custom_button.dart';
import 'package:new_nabni_app/view/widgets/custom_text_field.dart';

class ContractorsScreen extends StatefulWidget {
  const ContractorsScreen({super.key});

  @override
  State<ContractorsScreen> createState() => _ContractorsScreenState();
}

class _ContractorsScreenState extends State<ContractorsScreen> {
  @override
  void initState() {
    Get.find<SupplierController>()
        .getContractorsOrSuppliers(AppConstants.userTypes[1]);
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
              'المقاولين',
              style: TextStyle(color: Color(0xff8B7C61), fontWeight: FontWeight.bold, fontSize: 17,fontFamily: 'Cairo'),
            ),
            actions: [],
          ),
          body: GetBuilder<SupplierController>(builder: (controller) {
            return Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  controller.isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Two items per row
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return _item(controller.contractors![index]);
                          },
                          itemCount: controller.contractors!.length,
                        ),
                ],
              ),
            );
          })),
    );
  }

  _item(UserModel model) {
    int rating = double.parse(model.lastRating.toString()).toInt();

    return InkWell(
      onTap: () {
        Get.toNamed(RouteHelper.getSingleContractorRoute(model));
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (model.image == 'null')
                  CircleAvatar(
                      radius: 25,
                      backgroundImage:
                          AssetImage('assets/images/placeholder.png')),
                if (model.image != 'null')
                  CircleAvatar(
                      radius: 25, backgroundImage: NetworkImage(model.image ?? '')),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(model.username ?? '',
                        style: TextStyle(
                            color: Color(0xff8B7C61),
                            fontFamily: 'Cairo',
                            fontSize: 15,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  for (int index = 0; index < 5; index++)
                                    Icon(
                                      index < rating
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Colors.amber,
                                      size: 15,
                                    ),
                                ],
                              ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(model.bio ?? '',
                style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 13,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600)),
            const SizedBox(
              height: 8,
            ),
            const Spacer(),
            CustomButton(
              buttonText: 'المزيد',
              onPressed: () {
                Get.toNamed(RouteHelper.getSingleContractorRoute(model));
              },
            )
          ],
        ),
      ),
    );
  }
}
