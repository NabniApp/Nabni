

import 'package:get/get.dart';
import 'package:new_nabni_app/controller/auth_controller.dart';
import 'package:new_nabni_app/controller/client_controller.dart';
import 'package:new_nabni_app/controller/contractor_controller.dart';
import 'package:new_nabni_app/controller/supplier_controller.dart';

Future init() async {
  // Repository
  Get.lazyPut(() => AuthController());
  Get.lazyPut(() => SupplierController());
  Get.lazyPut(() => ClientController());
  Get.lazyPut(() => ContractorController());


}
