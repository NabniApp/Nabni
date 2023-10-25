import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/controller/bottom_bar_controller.dart';

class CustomeBottomBar extends StatelessWidget {
  const CustomeBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomBarController>(
        builder: (controller) => Stack(
              children: [
                IndexedStack(
                  index: controller.selectedIndex,
                  children: controller.pages,
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: CurvedNavigationBar(
                    backgroundColor: const Color.fromARGB(255, 139, 124, 97),
                    height: 50,
                    items: const <Widget>[
                      Icon(Icons.newspaper,
                          size: 25, color: Color.fromARGB(255, 139, 124, 97)),
                      Icon(Icons.chat,
                          size: 25, color: Color.fromARGB(255, 139, 124, 97)),
                      Icon(Icons.list_alt,
                          size: 25, color: Color.fromARGB(255, 139, 124, 97)),
                      Icon(Icons.home,
                          size: 25, color: Color.fromARGB(255, 139, 124, 97)),
                    ],
                    onTap: (index) {
                      controller.selectedIndex = index;
                      controller.update();
                    },
                  ),
                ),
              ],
            ));
  }
}
