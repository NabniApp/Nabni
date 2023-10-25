import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart' as cc;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/data/model/invoice_model.dart';
import 'package:new_nabni_app/data/model/material_model.dart';
import 'package:new_nabni_app/data/model/user_model.dart';
import 'package:new_nabni_app/utiles/app_constants.dart';
import 'package:new_nabni_app/utiles/preference.dart';
import 'package:new_nabni_app/utiles/route_helper.dart';
import 'package:new_nabni_app/view/widgets/custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupplierController extends GetxController implements GetxService {
  bool isLoading = true;
  Preference storage = Preference.shared;

  final FirebaseStorage firebase_storage = FirebaseStorage.instance;

  Future<String> uploadImage(File file) async {
    // Create a reference to the location where you want to store the file in Firebase Storage
    Reference ref =
        firebase_storage.ref().child('images/${DateTime.now().toString()}');

    // Upload the file to Firebase Storage
    UploadTask uploadTask = ref.putFile(file);

    // Wait for the upload to complete and return the download URL
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    // Return the download URL
    return downloadUrl;
  }

  Future addNewSubject(context,
      {username,
      quantity,
      price,
      date,
      subject_type,
      supplier_unit,
      image,
      created_by}) async {
    MaterialModel data = MaterialModel(
        username: username,
        quantity: quantity,
        price: price,
        date: date,
        subject_type: subject_type,
        supplier_unit: supplier_unit,
        image: image,
        created_by: created_by);
    FirebaseFirestore.instance
        .collection('materials')
        .add(data.toMap())
        .then((value) {
      FirebaseFirestore.instance
          .collection('materials')
          .doc(value.id)
          .update({'id': value.id}).then((value2) {
        showCustomSnackBar(context, 'تم اضافة المادة بنجاح', isError: false);
        Get.offAndToNamed(RouteHelper.getSubjectHistoryRoute());
        print('Done');
      }).catchError((error) {
        showCustomSnackBar(context, error.toString());
        print(error.toString());
      });
    });
  }

  List<MaterialModel> materials = [];
  List<MaterialModel> requests = [];

  List<UserModel>? suppliers;
  List<UserModel>? contractors;
  List<UserModel>? allSuppliers;
  List<InvoiceModel>? invoices;

  bool isgetDataLoading = true;

  Future<void> getMaterials() async {
    materials = [];
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("materials")
          .where('created_by',
              isEqualTo: storage.getString(AppConstants.USER_ID))
          .get();

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

  Future<void> getContractorsOrSuppliers(userType) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .where('user_type', isEqualTo: userType)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        if (userType == AppConstants.userTypes[0]) {
          suppliers = querySnapshot.docs.map((doc) {
            return UserModel.fromMap(doc.data() as Map<String, dynamic>);
          }).toList();
        } else {
          contractors = querySnapshot.docs.map((doc) {
            return UserModel.fromMap(doc.data() as Map<String, dynamic>);
          }).toList();
        }
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

  Future<void> getRequests() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(storage.getString(AppConstants.USER_ID))
          .collection('requests')
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        requests = querySnapshot.docs.map((doc) {
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

  Future<void> updateRequestStatus(
      BuildContext context,
      String project_id,
      String client_id,
      String reqId,
      String subject_type,
      String quantity) async {
    isLoading = true;
    update();

    final userDocRef = FirebaseFirestore.instance
        .collection('users')
        .doc(storage.getString(AppConstants.USER_ID)!);

    try {
      // Update the individual request document
      await userDocRef.collection('requests').doc(reqId).update({
        'isAcceptedBySupplier': true,
      });

      showCustomSnackBar(context, 'تم الموافقة بنجاح', isError: false);
      getRequests();
    } catch (error) {
      isLoading = false;
      update();
      print(error.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> filterSuppliers() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .where('user_type', isEqualTo: AppConstants.userTypes[0])
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        allSuppliers = querySnapshot.docs.map((doc) {
          return UserModel.fromMap(doc.data() as Map<String, dynamic>);
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

  removeSubject(context, id) async {
    isLoading = true;
    update();
    FirebaseFirestore.instance
        .collection('materials')
        .doc(id)
        .delete()
        .then((value) {
      showCustomSnackBar(context, 'Deleted Successfully', isError: false);
      getMaterials();
      isLoading = false;
      update();
    }).catchError((err) {
      isLoading = false;
      update();
      showCustomSnackBar(context, 'Error');
    });
  }

  Future<void> getContractorInvoices() async {
    isLoading = true;
    update();
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
}
