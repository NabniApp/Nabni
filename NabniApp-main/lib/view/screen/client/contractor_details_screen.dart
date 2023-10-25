import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/controller/client_controller.dart';
import 'package:new_nabni_app/controller/contractor_controller.dart';
import 'package:new_nabni_app/controller/supplier_controller.dart';
import 'package:new_nabni_app/data/model/my_project_model.dart';
import 'package:new_nabni_app/data/model/user_model.dart';
import 'package:new_nabni_app/utiles/app_constants.dart';
import 'package:new_nabni_app/utiles/preference.dart';
import 'package:new_nabni_app/utiles/route_helper.dart';
import 'package:new_nabni_app/view/widgets/custom_button.dart';
import 'package:new_nabni_app/view/widgets/custom_text_field.dart';

class ContractorDetailsScreen extends StatefulWidget {
  UserModel? model;
  ContractorDetailsScreen({super.key, required this.model});

  @override
  State<ContractorDetailsScreen> createState() =>
      _ContractorDetailsScreenState();
}

class _ContractorDetailsScreenState extends State<ContractorDetailsScreen> {
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
                  color: Color.fromARGB(255, 139, 124, 97),
                )),
            title: Text(
              'المقاول',
              style: TextStyle(color: Color.fromARGB(255, 139, 124, 97), fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 17),
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
                                    color: Color.fromARGB(255, 139, 124, 97),
                                    fontFamily: 'Cairo',
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600)),
                            const SizedBox(
                              height: 5,
                            ),
                            if (widget.model!.lastRating != null)
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
                                      size: 18,
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
                  const Text('عن المقاول',
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 17,
                          color: Color.fromARGB(255, 139, 124, 97),
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
                        style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('الاعمال السابقة',
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 17,
                          color: Color.fromARGB(255, 139, 124, 97),
                          fontWeight: FontWeight.w600)),
                  const SizedBox(
                    height: 10,
                  ),
                  GetBuilder<ContractorController>(builder: (controller) {
                    return controller.isLoading
                        ? const CircularProgressIndicator()
                        : controller.myProjects.isNotEmpty
                            ? GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2, // Number of columns
                                        mainAxisExtent: 250,
                                        mainAxisSpacing: 4,
                                        crossAxisSpacing: 5),
                                itemCount: controller.myProjects.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return _workItem(
                                      controller.myProjects[index], controller);
                                },
                              )
                            : const Center(child: Text('لم نجد اي مشاريع!'));
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  if (Preference.shared.getString(AppConstants.USER_TYPE) ==
                      AppConstants.userTypes[2])
                    CustomButton(
                      buttonText: 'بدء مشروع جديد',
                      onPressed: () {
                        Get.toNamed(
                            RouteHelper.getAddNewProjectRoute(widget.model!));
                      },
                    )
                ],
              ),
            );
          })),
    );
  }

  Widget _workItem(MyProjectModel model, ContractorController controller) {
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
        Container(
          width: 150,
          height: 150,
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                mainAxisSpacing: 4,
                crossAxisSpacing: 5),
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
        const SizedBox(
          height: 20,
        ),
        Text(
          model.name!,
          style: TextStyle(
              overflow: TextOverflow.ellipsis,
              color: Colors.brown,
              fontFamily: 'Cairo',
              fontSize: 17,
              fontWeight: FontWeight.bold),
        ),
      ]),
    );
  }
}
