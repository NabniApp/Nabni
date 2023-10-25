import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/controller/auth_controller.dart';
import 'package:new_nabni_app/utiles/route_helper.dart';

class ClientProfileScreen extends StatefulWidget {
  const ClientProfileScreen({super.key});

  @override
  State<ClientProfileScreen> createState() => _ClientProfileScreenState();
}

class _ClientProfileScreenState extends State<ClientProfileScreen> {
  @override
  void initState() {
    Get.find<AuthController>().userInfo();
    super.initState();
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
            'الملف الشخصي',
            style: TextStyle(color: Color(0xff8B7C61), fontWeight: FontWeight.bold ,fontFamily: 'Cairo',fontSize: 17),
          ),
          actions: [],
        ),
        body: GetBuilder<AuthController>(builder: (auth) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: auth.isgetDataLoading && auth.userData == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 20.0, top: 120.0),
                              margin: const EdgeInsets.only(top: 70.0),
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
                              child: Column(children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.email,
                                      color: Color(0xff8B7C61),
                                      size: 22,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(auth.userData?.email ?? '',
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 16,
                                        )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      color: Color(0xff8B7C61),
                                      size: 22,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(auth.userData?.phone ?? '',
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 16,
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ]),
                            ),
                            Positioned(
                                top: -10,
                                left: 0,
                                right: 0,
                                child: Container(
                                  margin: EdgeInsets.only(top: 30),
                                  child: Column(children: [
                                    if (auth.userData!.image == 'null')
                                      const CircleAvatar(
                                          radius: 50,
                                          backgroundImage: AssetImage(
                                              'assets/images/placeholder.jpg')),
                                    if (auth.userData!.image != 'null')
                                      CircleAvatar(
                                          radius: 50,
                                          backgroundImage: NetworkImage(
                                              auth.userData!.image ?? '')),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(auth.userData!.username!,
                                        style: TextStyle(
                                            color: Color(0xff8B7C61),
                                            fontFamily: 'Cairo',
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600)),
                                  ]),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.toNamed(
                                    RouteHelper.getProjectsHistoryRoute());
                              },
                              child: Container(
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
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.file_copy,
                                      color: Color(0xff8B7C61),
                                      size: 22,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text('سجل المشاريع',
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 16,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                print(auth.userData);
                                Get.toNamed(
                                    RouteHelper.getEditClientProfileRoute(
                                        auth.userData!));
                              },
                              child: Container(
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
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.edit,
                                      color: Color(0xff8B7C61),
                                      size: 22,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text('تعديل الملف الشخصي',
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 16,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(RouteHelper.getPrivacyRoute());
                              },
                              child: Container(
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
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.edit,
                                      color: Color(0xff8B7C61),
                                      size: 22,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('سياسية الخصوصية',
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 16,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                auth.signOut(context);
                              },
                              child: Container(
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
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.logout,
                                      color: Color(0xff8B7C61),
                                      size: 22,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text('تسجيل الخروج',
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 16,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
          );
        }),
      ),
    );
  }
}
