import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/data/model/invoice_model.dart';
import 'package:new_nabni_app/data/model/my_project_model.dart';
import 'package:new_nabni_app/data/model/project_model.dart';
import 'package:new_nabni_app/data/model/review_model.dart';
import 'package:new_nabni_app/data/model/material_model.dart';
import 'package:new_nabni_app/utiles/app_constants.dart';
import 'package:new_nabni_app/utiles/preference.dart';
import 'package:new_nabni_app/utiles/route_helper.dart';
import 'package:new_nabni_app/view/screen/contractor/choose_material_screen.dart';
import 'package:new_nabni_app/view/widgets/custom_snackbar.dart';

class ContractorController extends GetxController implements GetxService {
  bool isLoading = false;
  Preference storage = Preference.shared;
  List<ReviewModel> reviews = [];
  List<MaterialModel> materials = [];
  List<ProjectModel> projects = [];
  List<MyProjectModel> myProjects = [];
  final FirebaseStorage firebase_storage = FirebaseStorage.instance;
  List<InvoiceModel> invoices = [];

  Future<void> getContractorReviews(id) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(id)
          .collection('reviews')
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        reviews = querySnapshot.docs.map((doc) {
          return ReviewModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();
      }

      isLoading = false;
      update();
    } catch (error) {
      isLoading = false;
      update();
      print(error.toString());
      throw error; // Rethrow the error to handle it higher up in the call stack if needed.
    }
  }

  Future<void> getProjects() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("projects")
          .where('contractor_id',
              isEqualTo: storage.getString(AppConstants.USER_ID))
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        projects = querySnapshot.docs.map((doc) {
          return ProjectModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();
      }

      isLoading = false;
      update();
    } catch (error) {
      isLoading = false;
      update();
      print(error.toString());
      throw error; // Rethrow the error to handle it higher up in the call stack if needed.
    }
  }

  getInvoiceData(String projectId, String clientId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("invoices")
          .where('contractor_id',
              isEqualTo: storage.getString(AppConstants.USER_ID))
          .where('project_id', isEqualTo: projectId)
          .where('client_id', isEqualTo: clientId)
          .get();
      print(projectId);
      // print(clientId);
      print(querySnapshot.docs.isNotEmpty);
      if (querySnapshot.docs.isNotEmpty) {
        final items = querySnapshot.docs[0]['items'] as List<dynamic>;

        // Deserialize the list of items into MaterialItem objects
        final materialItems =
            items.map((item) => MaterialModel.fromMap(item)).toList();

        return {
          "materialItems": materialItems,
          "priceWork": querySnapshot.docs[0]['priceWork'],
          "invoice_id": querySnapshot.docs[0]['id'],
        };
      }

      isLoading = false;
      update();
      return []; // Return an empty list if no data is found.
    } catch (error) {
      isLoading = false;
      update();
      print(error.toString());
      return 'error';
    }
  }

  Future<void> getMyProjects({id}) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(id ?? storage.getString(AppConstants.USER_ID))
          .collection('my_works')
          .get();
      myProjects = [];
      if (querySnapshot.docs.isNotEmpty) {
        myProjects = querySnapshot.docs.map((doc) {
          return MyProjectModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();
      }

      isLoading = false;
      update();
    } catch (error) {
      isLoading = false;
      update();
      print(error.toString());
      throw error; // Rethrow the error to handle it higher up in the call stack if needed.
    }
  }

  Future<void> getMaterials({id}) async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection("materials").get();
      materials = [];
      if (querySnapshot.docs.isNotEmpty) {
        materials = querySnapshot.docs.map((doc) {
          return MaterialModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();
      }

      isLoading = false;
      update();
    } catch (error) {
      isLoading = false;
      update();
      print(error.toString());
      throw error; // Rethrow the error to handle it higher up in the call stack if needed.
    }
  }

  Future<void> getContractorInvoices() async {
    isLoading = true;
    update();
    print('storage.getString(AppConstants.USER_ID)');
    print(storage.getString(AppConstants.USER_ID));
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("invoices")
          .where('contractor_id',
              isEqualTo: storage.getString(AppConstants.USER_ID))
          .get();
      invoices = [];

      if (querySnapshot.docs.isNotEmpty) {
        invoices = querySnapshot.docs.map((doc) {
          return InvoiceModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();
      }

      isLoading = false;
      update();
    } catch (error) {
      isLoading = false;
      update();
      print(error.toString());
      throw error; // Rethrow the error to handle it higher up in the call stack if needed.
    }
  }

  Future removeProject(context, id) async {
    isLoading = true;
    update();
    FirebaseFirestore.instance
        .collection("users")
        .doc(storage.getString(AppConstants.USER_ID))
        .collection("my_works")
        .doc(id)
        .delete()
        .then((value) {
      showCustomSnackBar(context, 'Project Deleted Successfully!',
          isError: false);
      getMyProjects();
      isLoading = false;
      update();
    }).catchError((error) {
      isLoading = false;
      update();
      print(error.toString());
    });
  }

  Future updateStatus(context, project_id, client_id, status) async {
    isLoading = true;
    update();
    FirebaseFirestore.instance
        .collection("projects")
        .doc(project_id)
        .update({'status': status}).then((value) {
      showCustomSnackBar(
          context,
          status == 'finished'
              ? 'تم الانتهاء من المشروع بنجاح'
              : 'تم تعديل حالة المشروع بنجاح',
          isError: false);
      getProjects();
      if (status == 'done_deal') {
        Get.toNamed(
            RouteHelper.getSendContractScreenRoute(client_id, project_id));
      }
      isLoading = false;
      update();
    }).catchError((error) {
      isLoading = false;
      update();
      print(error.toString());
    });
  }

  Future addNewStep(
    context, {
    name,
    description,
    startDate,
    endDate,
    project_id,
  }) async {
    isLoading = true;
    update();

    FirebaseFirestore.instance
        .collection('projects')
        .doc(project_id)
        .collection('steps')
        .add({
      'step_name': name,
      'description': description,
      'startDate': startDate,
      'endDate': endDate,
    }).then((value) {
      showCustomSnackBar(context, 'تم اضافة خطوة بنجاح', isError: false);
      Navigator.pop(context);
      isLoading = false;
      update();
      print('Done');
    }).catchError((error) {
      showCustomSnackBar(context, error.toString());
      isLoading = false;
      update();
      print(error.toString());
    });
  }

  Future<void> addMaterials({
    required BuildContext context,
    required List<MaterialModel> materials,
    required String project_id,
  }) async {
    try {
      isLoading = true;
      update();

      final projectsCollection =
          FirebaseFirestore.instance.collection('projects');
      final materialsCollection =
          projectsCollection.doc(project_id).collection('materials');

      for (var material in materials) {
        await materialsCollection.add(material
            .toMap()); // Assuming MaterialModel has a toMap method to convert it to a Map.
      }

      await projectsCollection
          .doc(project_id)
          .update({'materialSelected': true});
      showCustomSnackBar(context, 'تم اضافة المواد بنجاح', isError: false);
      getProjects();

      isLoading = false;
      update();
      print('Done');
    } catch (error) {
      showCustomSnackBar(context, error.toString());
      isLoading = false;
      update();
      print(error.toString());
    }
  }

  Future<void> updateInvoice(
      {required BuildContext context,
      required String invoice_id,
      required String priceWork}) async {
    try {
      isLoading = true;
      update();

      final invoicesCollection =
          FirebaseFirestore.instance.collection('invoices');

      await invoicesCollection.doc(invoice_id).update({'priceWork': priceWork});
      showCustomSnackBar(context, 'تم تعديل الفاتورة بنجاح', isError: false);
      getProjects();
      Navigator.pop(context);
      isLoading = false;
      update();
      print('Done');
    } catch (error) {
      showCustomSnackBar(context, error.toString());
      isLoading = false;
      update();
      print(error.toString());
    }
  }

  Future<String> uploadImage(File file) async {
    // Create a reference to the location where you want to store the file in Firebase Storage
    Reference ref =
        firebase_storage.ref().child('files/${DateTime.now().toString()}');

    // Upload the file to Firebase Storage
    UploadTask uploadTask = ref.putFile(file);

    // Wait for the upload to complete and return the download URL
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    // Return the download URL
    return downloadUrl;
  }

  Future addNewWork(
    context, {
    name,
    description,
    space,
    price,
    List<File>? images,
  }) async {
    isLoading = true;
    update();
    // Create a list to store the download URLs of uploaded images
    List<String> imageUrls = [];

    // Upload each selected image and store its download URL
    for (var imageFile in images!) {
      String imageUrl = await uploadImage(imageFile);
      imageUrls.add(imageUrl);
    }
    FirebaseFirestore.instance
        .collection('users')
        .doc(storage.getString(AppConstants.USER_ID))
        .collection('my_works')
        .add({
      'name': name,
      'description': description,
      'space': space,
      'price': price,
      'id': '',
      'images': imageUrls,
    }).then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(storage.getString(AppConstants.USER_ID))
          .collection('my_works')
          .doc(value.id)
          .update({'id': value.id}).then((value2) {
        getMyProjects();
        showCustomSnackBar(context, 'تم اضافة المشروع بنجاح', isError: false);
        Navigator.pop(context);
        isLoading = false;
        update();
        print('Done');
      }).catchError((error) {
        showCustomSnackBar(context, error.toString());
        isLoading = false;
        update();
        print(error.toString());
      });
    }).catchError((error) {
      showCustomSnackBar(context, error.toString());
      isLoading = false;
      update();
      print(error.toString());
    });
  }

  Future sendContract(
    context, {
    project_id,
    file,
  }) async {
    isLoading = true;
    update();

    FirebaseFirestore.instance
        .collection('projects')
        .doc(project_id)
        .collection('contract')
        .add({
      'image': await uploadImage(file),
      'date': DateTime.now().toIso8601String(),
    }).then((value) {
      showCustomSnackBar(context, 'تم ارسال العقد بنجاح', isError: false);
      Navigator.pop(context);
      isLoading = false;
      update();
      print('Done');
    }).catchError((error) {
      showCustomSnackBar(context, error.toString());
      isLoading = false;
      update();
      print(error.toString());
    });
  }
}
