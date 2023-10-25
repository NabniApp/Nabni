import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/controller/contractor_controller.dart';
import 'package:new_nabni_app/controller/supplier_controller.dart';
import 'package:new_nabni_app/data/model/my_project_model.dart';
import 'package:new_nabni_app/data/model/user_model.dart';
import 'package:new_nabni_app/utiles/app_constants.dart';
import 'package:new_nabni_app/utiles/preference.dart';
import 'package:new_nabni_app/view/widgets/custom_button.dart';

class SupplierDetailsScreen extends StatefulWidget {
  UserModel? model;
  SupplierDetailsScreen({super.key, required this.model});

  @override
  State<SupplierDetailsScreen> createState() => _SupplierDetailsScreenState();
}

class _SupplierDetailsScreenState extends State<SupplierDetailsScreen> {
  @override
  void initState() {
    Get.find<SupplierController>()
        .getContractorsOrSuppliers(AppConstants.userTypes[1]);
    Get.find<ContractorController>().getMyProjects(id: widget.model?.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int rating = double.parse(widget.model!.lastRating.toString()).toInt();

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
              'المورد',
              style: TextStyle(color: Color(0xff8B7C61), fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'Cairo'),
            ),
            actions: [],
          ),
          body: GetBuilder<SupplierController>(builder: (controller) {
            return Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        if (widget.model!.image == 'null')
                          const CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  AssetImage('assets/images/placeholder.jpg')),
                        if (widget.model!.image != 'null')
                          CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  NetworkImage(widget.model!.image ?? '')),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.model!.username!,
                                style: TextStyle(
                                    color: Color(0xff8B7C61),
                                    fontFamily: 'Cairo',
                                    fontSize: 17,
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
                                    size: 20,
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('عن المورد',
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 17,
                          color: Color(0xff8B7C61),
                          fontWeight: FontWeight.w600)),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(widget.model!.bio ?? '',
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    buttonText: 'محادثة',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CometChatConversationsWithMessages(
                            conversationsConfiguration:
                                ConversationsConfiguration(
                                    backButton: IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.black,
                                        ))),
                            user: User(
                                uid: widget.model!.id!,
                                name: widget.model!.username!),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            );
          })),
    );
  }
}
