import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/data/model/invoice_model.dart';
import 'package:new_nabni_app/data/model/project_model.dart';
import 'package:new_nabni_app/data/model/step_model.dart';
import 'package:new_nabni_app/data/model/material_model.dart';
import 'package:new_nabni_app/data/model/user_model.dart';
import 'package:new_nabni_app/utiles/app_constants.dart';
import 'package:new_nabni_app/utiles/preference.dart';
import 'package:new_nabni_app/utiles/route_helper.dart';
import 'package:new_nabni_app/view/screen/contractor/choose_material_screen.dart';
import 'package:new_nabni_app/view/widgets/custom_button.dart';
import 'package:new_nabni_app/view/widgets/custom_snackbar.dart';

class ClientController extends GetxController implements GetxService {
  bool isLoading = false;
  Preference storage = Preference.shared;
  List<ProjectModel> projects = [];
  List<InvoiceModel> invoices = [];
  List<StepModel> projectSteps = [];

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

  Future addNewProject(context,
      {description,
      price,
      lat,
      lng,
      contractorId,
      fileIdentity,
      fileLicence,
      fileMap}) async {
    isLoading = true;
    update();

    String image1 = await uploadImage(fileIdentity);
    String image2 = await uploadImage(fileLicence);
    String image3 = await uploadImage(fileMap);

    ProjectModel data = ProjectModel(
        description: description,
        price: price,
        date: DateTime.now().toIso8601String(),
        lat: lat,
        lng: lng,
        client_id: storage.getString(AppConstants.USER_ID),
        client_name: await getContractorName( id: storage.getString(AppConstants.USER_ID)),
        contractor_id: contractorId,
        contractor_name: await getContractorName(id: contractorId),
        status: 'under_review',
        isReviewAndEnd: false,
        imageIdentity: image1,
        imageLicence: image2,
        imageMap: image3,
        materials: selectedMaterials,
        height: height.text,
        width: width.text,
        totalPriceOfMaterials: calculateTotalPrice().toString());
    FirebaseFirestore.instance
        .collection('projects')
        .add(data.toMap())
        .then((value) {
      FirebaseFirestore.instance
          .collection('projects')
          .doc(value.id)
          .update({'id': value.id}).then((value2) {
        getProjects();
        selectedMaterials = [];
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
    });
  }

  Future addReview(
    context, {
    content,
    rating,
    contractor_id,
    project_id,
  }) async {
    isLoading = true;
    update();

    FirebaseFirestore.instance
        .collection('users')
        .doc(contractor_id)
        .collection('reviews')
        .add({
      'content': content,
      'rating': rating,
      'client_id': storage.getString(AppConstants.USER_ID)
    }).then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(contractor_id)
          .update({'lastRating': rating});
      FirebaseFirestore.instance
          .collection('projects')
          .doc(project_id)
          .update({'isReviewAndEnd': true}).then((value2) {
        getProjects();
        showCustomSnackBar(context, 'تم المراجعة بنجاح', isError: false);
        Navigator.pop(context);
        isLoading = false;
        update();
        print('Done');
      });
    }).catchError((error) {
      showCustomSnackBar(context, error.toString());
      isLoading = false;
      update();
      print(error.toString());
    });
  }

  Future addInvoice(context,
      {clientName,
      project_id,
      client_id,
      totalPrice,
      priceWork,
      List? items}) async {
    isLoading = true;
    update();
    List firestoreItems = items?.map((item) => item.toMap()).toList() ?? [];
    FirebaseFirestore.instance.collection('invoices').add({
      'id': '',
      'clientName': clientName,
      'contractorName':
          await getContractorName(id: storage.getString(AppConstants.USER_ID)),
      'project_id': project_id,
      'client_id': client_id,
      'totalPrice': totalPrice,
      'priceWork': priceWork,
      'contractor_id': storage.getString(AppConstants.USER_ID),
      'date': DateTime.now().toIso8601String(),
      'items': firestoreItems,
      'is_confirmed_by_client': false,
    }).then((value) {
      FirebaseFirestore.instance
          .collection('invoices')
          .doc(value.id)
          .update({'id': value.id}).then((value2) {
        sendRequestToSupplier(
            project_id: project_id, client_id: client_id, items: items);
        getProjects();
        showCustomSnackBar(context, 'تم ارسال الفاتورة بنجاح', isError: false);
        Navigator.pop(context);
        isLoading = false;
        update();
        print('Done');
      });
    }).catchError((error) {
      showCustomSnackBar(context, error.toString());
      isLoading = false;
      update();
      print(error.toString());
    });
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future sendRequestToSupplier({project_id, client_id, List? items}) async {
    items!.forEach((element) async {
      final requestRef = await _firestore
          .collection('users')
          .doc(element.created_by)
          .collection('requests')
          .add({
        'username': await getContractorName(
            id: storage.getString(AppConstants.USER_ID)),
        'project_id': project_id,
        'client_id': client_id,
        'quantity': element.quantity,
        'price': element.price,
        'subject_type': element.subject_type,
        'supplier_unit': element.supplier_unit,
        'contractor_id': storage.getString(AppConstants.USER_ID),
        'isAcceptedBySupplier': false
      });

      await requestRef.update({'id': requestRef.id});
    });
  }

  Future agreeInvoice(context, {invoice_id}) async {
    print(invoice_id);
    isLoading = true;
    update();

    FirebaseFirestore.instance
        .collection('invoices')
        .doc(invoice_id)
        .update({'is_confirmed_by_client': true}).then((value2) {
      getProjects();
      showCustomSnackBar(context, 'تم الموافقة علي الفاتورة بنجاح',
          isError: false);
      // Navigator.pop(context);
      Get.offAndToNamed(RouteHelper.getInitialRoute());
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

  getInvoiceDataForClient(String projectId, String contractorId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("invoices")
          .where('client_id',
              isEqualTo: storage.getString(AppConstants.USER_ID))
          .where('project_id', isEqualTo: projectId)
          .where('contractor_id', isEqualTo: contractorId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final items = querySnapshot.docs[0]['items'] as List<dynamic>;

        // Deserialize the list of items into MaterialItem objects
        final materialItems =
            items.map((item) => MaterialModel.fromMap(item)).toList();

        return {
          "materialItems": materialItems,
          "priceWork": querySnapshot.docs[0]['priceWork'],
          "invoice_id": querySnapshot.docs[0].id,
          'is_confirmed_by_client':
              querySnapshot.docs[0]['is_confirmed_by_client'].toString(),
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

  Future<void> getClientInvoices() async {
    isLoading = true;
    update();
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("invoices")
          .where('client_id',
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

  Future<void> getProjects() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("projects")
          .where('client_id',
              isEqualTo: storage.getString(AppConstants.USER_ID))
          .get();
      print(querySnapshot.docs);
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

  Future getContractImage(projectId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("projects")
          .doc(projectId)
          .collection('contract')
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        print(querySnapshot.docs[0]['image']);
        return querySnapshot.docs[0]['image'];
      }

      isLoading = false;
      update();
    } catch (error) {
      isLoading = false;
      update();
      print(error.toString());
      return 'null';
    }
  }

  Future<void> getProjectSteps(projectId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("projects")
          .doc(projectId)
          .collection('steps')
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        projectSteps = querySnapshot.docs.map((doc) {
          return StepModel.fromMap(doc.data() as Map<String, dynamic>);
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

  Future<void> getContractorReviews() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("projects")
          .where('client_id',
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

  Future<String> getContractorName({id}) async {
    try {
      final documentSnapshot =
          await FirebaseFirestore.instance.collection("users").doc(id).get();
      return documentSnapshot.data()!['username'];
    } catch (error) {
      print(error.toString());
      throw error; // Rethrow the error to handle it higher up in the call stack if needed.
    }
  }

  Future getUserData({id}) async {
    try {
      final documentSnapshot =
          await FirebaseFirestore.instance.collection("users").doc(id).get();
      return UserModel.fromMap(documentSnapshot.data()!);
    } catch (error) {
      print(error.toString());
      throw error; // Rethrow the error to handle it higher up in the call stack if needed.
    }
  }

  // 3D ROOM

  TextEditingController height = TextEditingController();
  TextEditingController width = TextEditingController();
  List<MaterialModel> selectedMaterials = [];

  Future<void> onSelectMaterial(BuildContext context, String material) async {
    List<MaterialModel> _materials = [];
    print("test");
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("materials")
          .where('subject_type', isEqualTo: material)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        _materials = querySnapshot.docs.map((doc) {
          return MaterialModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();
        // ignore: use_build_context_synchronously
        showMaterialDialog(context, material, _materials);
      } else {
        showCustomSnackBar(context, 'لا توجد هذه الماده');
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

  double calculateTotalPrice() {
    double total = 0.0;

    for (final order in selectedMaterials) {
      final itemPrice = double.parse(order.price!);
      final totalPriceForItem =
          itemPrice * (double.parse(width.text) * double.parse(height.text));
      total += totalPriceForItem;
    }

    return total;
  }

  showMaterialDialog(
      BuildContext context, material, List<MaterialModel> data) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      material,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo'),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: .8,
                      crossAxisCount: 2, // Two items per row
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return _materialItem(context, data[index]);
                    },
                    itemCount: data.length,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    margin: const EdgeInsets.all(10.0),
                    buttonText: 'تم',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  showMaterialSummeryDialog(BuildContext context) async {
    final total = calculateTotalPrice();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      'طلبات الغرفة الافتراضية',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo'),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 150,
                    child: ListView.builder(
                      itemCount: selectedMaterials.length,
                      itemBuilder: (context, index) {
                        final order = selectedMaterials[index];

                        return Card(
                          child: Row(
                            children: [
                              Text((index + 1).toString()),
                              Spacer(),
                              Text(order.username!),
                              Spacer(),
                              SizedBox(width: 10),
                              Text('${order.price} ريال'),
                              Spacer(),
                              Text(
                                  '${int.parse(order.price!) * int.parse(width.text)} ريال'),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'المساحة',
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo'),
                      ),
                      Text(
                        "${width.text}x${height.text}",
                        style:
                            const TextStyle(fontSize: 15, fontFamily: 'Cairo'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'السعر التقريبي',
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo'),
                      ),
                      Text(
                        "${total.toStringAsFixed(2)} ريال",
                        style:
                            const TextStyle(fontSize: 15, fontFamily: 'Cairo'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    margin: const EdgeInsets.all(10.0),
                    buttonText: 'تم',
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _materialItem(context, MaterialModel model) {
    return InkWell(
      onTap: () {
        if (!selectedMaterials.contains(model)) {
          selectedMaterials.add(model);
          showCustomSnackBar(context, 'تم اختيار المادة', isError: false);
          update();
          print(selectedMaterials);
          Navigator.pop(context);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200, spreadRadius: 1, blurRadius: 5)
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              model.image!,
              fit: BoxFit.cover,
              height: 80,
              width: double.infinity,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(model.subject_type ?? '',
                style: TextStyle(
                    color: Colors.brown,
                    fontFamily: 'Cairo',
                    fontSize: 17,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 5,
            ),
            Text('${model.price} ريال',
                style: TextStyle(fontFamily: 'Cairo', fontSize: 17)),
          ],
        ),
      ),
    );
  }
}
