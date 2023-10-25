import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/data/model/material_model.dart';
import 'package:new_nabni_app/data/model/user_model.dart';
import 'package:new_nabni_app/view/screen/auth/forget_pass_screen.dart';
import 'package:new_nabni_app/view/screen/auth/login_screen.dart';
import 'package:new_nabni_app/view/screen/auth/register_screen.dart';
import 'package:new_nabni_app/view/screen/client/3d_view_screen.dart';
import 'package:new_nabni_app/view/screen/client/client_invoce_info.dart';
import 'package:new_nabni_app/view/screen/client/client_invoices_screen.dart';
import 'package:new_nabni_app/view/screen/client/client_profile_screen.dart';
import 'package:new_nabni_app/view/screen/client/client_projects_history_screen.dart';
import 'package:new_nabni_app/view/screen/client/contractor_details_screen.dart';
import 'package:new_nabni_app/view/screen/client/contractors_screen.dart';
import 'package:new_nabni_app/view/screen/client/edit_client_profile_screen.dart';
import 'package:new_nabni_app/view/screen/client/add_new_project_screen.dart';
import 'package:new_nabni_app/view/screen/client/project_progress_screen.dart';
import 'package:new_nabni_app/view/screen/client/review_contractor_screen.dart';
import 'package:new_nabni_app/view/screen/communication/chat_screen.dart';
import 'package:new_nabni_app/view/screen/contractor/add_new_step_screen.dart';
import 'package:new_nabni_app/view/screen/contractor/add_new_work_screen.dart';
import 'package:new_nabni_app/view/screen/contractor/choose_material_screen.dart';
import 'package:new_nabni_app/view/screen/contractor/contract_works_history_screen.dart';
import 'package:new_nabni_app/view/screen/contractor/contractor_profile_screen.dart';
import 'package:new_nabni_app/view/screen/contractor/edit_invoice_screen.dart';
import 'package:new_nabni_app/view/screen/contractor/edit_contractor_profile_screen.dart';
import 'package:new_nabni_app/view/screen/contractor/review_clients_screen.dart';
import 'package:new_nabni_app/view/screen/contractor/send_contract_screen.dart';
import 'package:new_nabni_app/view/screen/contractor/suppliers_screen.dart';
import 'package:new_nabni_app/view/screen/dashboard/main_screen.dart';
import 'package:new_nabni_app/view/screen/onboarding/onboaring_screen.dart';
import 'package:new_nabni_app/view/screen/pdf_viewer_screen.dart';
import 'package:new_nabni_app/view/screen/privacy_screen.dart';
import 'package:new_nabni_app/view/screen/splash/splash_screen.dart';
import 'package:new_nabni_app/view/screen/supplier/add_new_material_screen.dart';
import 'package:new_nabni_app/view/screen/supplier/edit_supplier_profile_screen.dart';
import 'package:new_nabni_app/view/screen/supplier/materials_history_screen.dart';
import 'package:new_nabni_app/view/screen/supplier/supplier_details_screen.dart';
import 'package:new_nabni_app/view/screen/supplier/supplier_invoice_info.dart';
import 'package:new_nabni_app/view/screen/supplier/supplier_profile_screen.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String settings = '/settings';
  static const String subject_history = '/subject-history';

  static const String projects_history = '/projects-history';
  static const String contractor_reviews = '/contractor_reviews';
  static const String add_contractor_review = '/add_contractor_review';
  static const String contractor_history = '/contractor-history';
  static const String project_progress = '/project-progress';
  static const String choose_material = '/choose-material';
  static const String supplier_invoice = '/supplier-invoice';
  static const String invoice = '/invoice';
  static const String edit_invoice = '/edit_invoice';
  
  static const String pdf_view = '/pdf_view';
  static const String add_new_material = '/add-new-subject';
  static const String add_new_project = '/add-new-project';
  static const String add_new_work = '/add-new-work';

  static const String supplier_profile = '/supplier-profile';
  static const String suppliers = '/suppliers';
  static const String threeDRoom = '/3d-room';

  static const String edit_supplier_profile = '/edit-supplier-profile';
  static const String edit_client_profile = '/edit-client-profile';
  static const String edit_contractor_profile = '/edit-contractor-profile';

  static const String client_profile = '/client-profile';
  static const String contractor_profile = '/contractor-profile';
  static const String chat_screen = '/chat-screen';
  static const String send_contract_screen = '/send-contract-screen';

  static const String new_step = '/new-step-screen';

  static const String contractors = '/contractors';
  static const String single_contractor = '/single-contractor';
  static const String single_supplier = '/single-supplier';

  static const String addPost = '/add-post';
  static const String privacy = '/privacy';

  static const String editProfile = '/edit-profile';
  static const String onBoarding = '/on-boarding';
  static const String login = '/sign-in';
  static const String register = '/sign-up';
  static const String forgetPassword = '/forget-password';

  static const String changePassword = '/change-password';

  static String getInitialRoute({String? user_type}) =>
      '$initial?user_type=$user_type';

  static String getSettingsRoute() => '$settings';

  static String getSplashRoute() => '$splash';
  static String getPrivacyRoute() => '$privacy';
  static String getAddPostRoute() => '$addPost';
  static String getEditProfileRoute() => '$editProfile';
  static String getChangePasswordRoute() => '$changePassword';
  static String getSubjectHistoryRoute() => '$subject_history';
  static String getContractorReviewRoute() => '$contractor_reviews';
  static String getThreeDRoomRoute() => '$threeDRoom';

  static String getAddContractorReviewRoute(
      UserModel _model, String project_id) {
    final modelMap = _model.toMap(); // Convert UserModel to a map
    final model = Uri.encodeComponent(jsonEncode(modelMap));
    return '$add_contractor_review?model=$model&project_id=$project_id';
  }

  static String getProjectsHistoryRoute() => '$projects_history';
  static String getContractorWorksHistoryRoute() => '$contractor_history';
  static String getAddNewWorkRoute() => '$add_new_work';
  static String getChatScreenRoute(String id) => '$chat_screen?id=$id';
  static String getPdfViewerScreenRoute(String url) => '$pdf_view?url=$url';
  static String getChooseMaterialRoute(
      String id, String client_name, String client_id) {
    return '$choose_material?project_id=$id&client_name=$client_name&client_id=$client_id';
  }

  static String getSendContractScreenRoute(
          String client_id, String project_id) =>
      '$send_contract_screen?client_id=$client_id&project_id=$project_id';

  static String getProjectProgressRoute(String id) =>
      '$project_progress?project_id=$id';

  static String getAddNewStepScreenRoute(String id) => '$new_step?id=$id';

  static String getAddNewMaterialRoute() => '$add_new_material';

  static String getAddNewProjectRoute(UserModel _model) {
    final modelMap = _model.toMap(); // Convert UserModel to a map
    final model = Uri.encodeComponent(jsonEncode(modelMap));
    return '$add_new_project?model=$model';
  }

  static String getInvoiceRoute(List<MaterialModel> listOfMaterials,
      client_name, client_id, project_id, priceWork,
      {justShow = false, String? isConfirmedByClient, invoice_id}) {
    final listOfMaterialsMap =
        listOfMaterials.map((item) => item.toMap()).toList();

    // Encode the list of materials as JSON
    final materialsJson = jsonEncode(listOfMaterialsMap);

    // Construct the route with query parameters
    return '$invoice?materials=$materialsJson&client_name=$client_name&project_id=$project_id&client_id=$client_id&justShow=$justShow&priceWork=$priceWork&isConfirmedByClient=$isConfirmedByClient&invoice_id=$invoice_id';
  }

    static String getEditInvoiceRoute(List<MaterialModel> listOfMaterials,
      client_name, client_id, project_id, priceWork,
      {justShow = false, String? isConfirmedByClient, invoice_id}) {
    final listOfMaterialsMap =
        listOfMaterials.map((item) => item.toMap()).toList();

    // Encode the list of materials as JSON
    final materialsJson = jsonEncode(listOfMaterialsMap);

    // Construct the route with query parameters
    return '$edit_invoice?materials=$materialsJson&client_name=$client_name&project_id=$project_id&client_id=$client_id&justShow=$justShow&priceWork=$priceWork&isConfirmedByClient=$isConfirmedByClient&invoice_id=$invoice_id';
  }

  static String getSupplierInvoiceRoute(
      List<MaterialModel> listOfMaterials, client_name,
      {invoice_id}) {
    final listOfMaterialsMap =
        listOfMaterials.map((item) => item.toMap()).toList();

    // Encode the list of materials as JSON
    final materialsJson = jsonEncode(listOfMaterialsMap);

    // Construct the route with query parameters
    return '$supplier_invoice?materials=$materialsJson&client_name=$client_name&invoice_id=$invoice_id';
  }

  static String getSupplierProfileRoute() => '$supplier_profile';
  static String getSuppliersRoute() => '$suppliers';

  static String getClientProfileRoute() => '$client_profile';
  static String getContractorProfileRoute() => '$contractor_profile';
  static String getContractorsRoute() => '$contractors';
  static String getSingleContractorRoute(UserModel _model) {
    final modelMap = _model.toMap(); // Convert UserModel to a map
    final model = Uri.encodeComponent(jsonEncode(modelMap));
    return '$single_contractor?model=$model';
  }

  static String getSingleSupplierRoute(UserModel _model) {
    final modelMap = _model.toMap(); // Convert UserModel to a map
    final model = Uri.encodeComponent(jsonEncode(modelMap));
    return '$single_supplier?model=$model';
  }

  static String getEditSupplierProfileRoute(UserModel _model) {
    final modelMap = _model.toMap(); // Convert UserModel to a map
    final model = Uri.encodeComponent(jsonEncode(modelMap));
    return '$edit_supplier_profile?model=$model';
  }

  static String getEditClientProfileRoute(UserModel _model) {
    final modelMap = _model.toMap(); // Convert UserModel to a map
    final model = Uri.encodeComponent(jsonEncode(modelMap));
    return '$edit_client_profile?model=$model';
  }

  static String getEditContractorPofileRoute(UserModel _model) {
    final modelMap = _model.toMap(); // Convert UserModel to a map
    final model = Uri.encodeComponent(jsonEncode(modelMap));
    return '$edit_contractor_profile?model=$model';
  }

  static String getOnBoardingRoute() => '$onBoarding';
  static String getLoginRoute() => '$login';
  static String getRegisterRoute() => '$register';
  static String getForgetPasswordRoute() => '$forgetPassword';

  static List<GetPage> routes = [
    GetPage(
        name: initial,
        page: () => MainScreen(user_type: Get.parameters['user_type'])),
    GetPage(
        name: splash,
        page: () {
          return SplashScreen();
        }),

    GetPage(name: privacy, page: () => TermsAndConditionsScreen()),
    GetPage(name: onBoarding, page: () => OnBoardingScreen()),
    // GetPage(name: editProfile, page: () => UpdateUserInfoScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: register, page: () => RegisterScreen()),
    GetPage(name: forgetPassword, page: () => ForgetPasswordScreen()),

    // Supplier
    GetPage(name: subject_history, page: () => MaterialsHistoryScreen()),
    GetPage(name: add_new_material, page: () => AddNewMaterialScreen()),
    GetPage(name: add_new_work, page: () => AddNewWorkScreen()),
    GetPage(name: suppliers, page: () => SuppliersScreen()),

    GetPage(
        name: add_new_project,
        page: () => AddNewProjectScreen(
              contractor:
                  UserModel.fromMap(jsonDecode(Get.parameters['model']!)),
            )),

    GetPage(name: supplier_profile, page: () => SupplierProfileScreen()),
    GetPage(
        name: edit_supplier_profile,
        page: () => EditSupplierProfileScreen(
              model: UserModel.fromMap(jsonDecode(Get.parameters['model']!)),
            )),
    GetPage(
        name: edit_client_profile,
        page: () => EditClientProfileScreen(
              model: UserModel.fromMap(jsonDecode(Get.parameters['model']!)),
            )),

    GetPage(
        name: supplier_invoice,
        page: () {
          final materialsList = jsonDecode(Get.parameters['materials']!)
              .map((itemJson) => MaterialModel.fromMap(itemJson))
              .toList();
          return SupplierInvoiceInfo(
            clientName: Get.parameters['client_name']!,
            invoice_id: Get.parameters['invoice_id']!,
            items: materialsList,
          );
        }),

    GetPage(
        name: invoice,
        page: () {
          final materialsList = jsonDecode(Get.parameters['materials']!)
              .map((itemJson) => MaterialModel.fromMap(itemJson))
              .toList();
          return ClientInvoceInfo(
            clientName: Get.parameters['client_name']!,
            projectId: Get.parameters['project_id']!,
            client_id: Get.parameters['client_id']!,
            priceWork: Get.parameters['priceWork']!,
            isConfirmedByClient: Get.parameters['isConfirmedByClient']!,
            justShow: Get.parameters['justShow']!,
            invoice_id: Get.parameters['invoice_id']!,
            items: materialsList,
          );
        }),

        GetPage(
        name: edit_invoice,
        page: () {
          final materialsList = jsonDecode(Get.parameters['materials']!)
              .map((itemJson) => MaterialModel.fromMap(itemJson))
              .toList();
          return EditInvoiceScreen(
            clientName: Get.parameters['client_name']!,
            projectId: Get.parameters['project_id']!,
            client_id: Get.parameters['client_id']!,
            priceWork: Get.parameters['priceWork']!,
            isConfirmedByClient: Get.parameters['isConfirmedByClient']!,
            invoice_id: Get.parameters['invoice_id']!,
            items: materialsList,
          );
        }),

        

    GetPage(
        name: pdf_view,
        page: () {
          return PDFViewerPage(Get.parameters['url']!);
        }),

    GetPage(
        name: edit_contractor_profile,
        page: () => EditcontractorProfileScreen(
              model: UserModel.fromMap(jsonDecode(Get.parameters['model']!)),
            )),

    // Client
    GetPage(name: client_profile, page: () => ClientProfileScreen()),
    GetPage(name: contractor_profile, page: () => ContractorProfileScreen()),
    GetPage(name: threeDRoom, page: () => Cube3D()),
    GetPage(
        name: chat_screen,
        page: () => ChatScreen(
              id: Get.parameters['id']!,
            )),
    GetPage(
        name: choose_material,
        page: () {
          return ChooseMaterialScreen(
            project_id: Get.parameters['project_id']!,
            client_id: Get.parameters['client_id']!,
            client_name: Get.parameters['client_name']!,
          );
        }),

    GetPage(
        name: send_contract_screen,
        page: () => SendContractScreen(
              project_id: Get.parameters['project_id']!,
              client_id: Get.parameters['client_id']!,
            )),

    GetPage(
        name: new_step,
        page: () => AddNewStepScreen(
              id: Get.parameters['id']!,
            )),
    GetPage(
        name: project_progress,
        page: () => ProjectProgressScreen(
              projectId: Get.parameters['project_id']!,
            )),

    GetPage(
        name: add_contractor_review,
        page: () => ReviewContractorScreen(
              model: UserModel.fromMap(jsonDecode(Get.parameters['model']!)),
              project_id: Get.parameters['project_id']!,
            )),

    GetPage(name: projects_history, page: () => ClientProjectHistoryScreen()),
    GetPage(name: contractor_reviews, page: () => ReviewClientScreen()),

    GetPage(name: contractor_history, page: () => ContractWorksHistoryScreen()),
    GetPage(name: contractors, page: () => ContractorsScreen()),
    GetPage(
        name: single_contractor,
        page: () => ContractorDetailsScreen(
              model: UserModel.fromMap(jsonDecode(Get.parameters['model']!)),
            )),
    GetPage(
        name: single_supplier,
        page: () => SupplierDetailsScreen(
              model: UserModel.fromMap(jsonDecode(Get.parameters['model']!)),
            )),
  ];

  static getRoute(Widget navigateTo) {
    return navigateTo;
  }
}
