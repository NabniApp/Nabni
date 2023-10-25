import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart' as cc;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/data/model/user_model.dart';
import 'package:new_nabni_app/utiles/app_constants.dart';
import 'package:new_nabni_app/utiles/preference.dart';
import 'package:new_nabni_app/utiles/route_helper.dart';
import 'package:new_nabni_app/view/widgets/custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController implements GetxService {
  bool isLoading = false;
  bool _notification = true;
  bool _acceptTerms = true;
  Preference storage = Preference.shared;

  final FirebaseStorage firebase_storage = FirebaseStorage.instance;

  Future<String> uploadImage(File file) async {
    // Create a reference to the location where you want to store the file in Firebase Storage
    Reference ref = firebase_storage
        .ref()
        .child('users/images/${DateTime.now().toString()}');

    // Upload the file to Firebase Storage
    UploadTask uploadTask = ref.putFile(file);

    // Wait for the upload to complete and return the download URL
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    // Return the download URL
    return downloadUrl;
  }

  Future userLogin(
    context, {
    required String email,
    required String password,
  }) async {
    isLoading = true;
    update();
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      // if (value.user!.emailVerified) {
      print(value.toString());
      //initialize var userId to accessed and global from everywhere
      storage.setString(AppConstants.USER_ID, value.user!.uid);
      storage.setString(AppConstants.IS_LOGIN, '1');

      await cc.CometChat.login(value.user!.uid, AppConstants.COMETCHAT_AUTH_KEY,
          onSuccess: (cc.User user) {
        debugPrint("Login Successful : $user");
      }, onError: (cc.CometChatException e) {
        debugPrint("Login failed with exception:  ${e.message}");
      });

      await userInfo(userId: value.user!.uid).then((user_type) {
        isLoading = false;
        update();
        showCustomSnackBar(context, 'تم تسجيل الدخول!', isError: false);
        storage.setString(AppConstants.USER_TYPE, user_type);
        Get.offAndToNamed(RouteHelper.getInitialRoute(user_type: user_type));
      });
      // } else {
      //   isLoading = false;
      //   update();
      //   showCustomSnackBar(context, 'Please Verify your email!');
      // }
    }).catchError((error) {
      isLoading = false;
      update();
      if (error is FirebaseAuthException) {
        // Get the code property from the error.
        String code = error.code;
        switch (error.code) {
          case "ERROR_EMAIL_ALREADY_IN_USE":
          case "account-exists-with-different-credential":
          case "email-already-in-use":
            error = "Email already used. Go to login page.";
            print(error);
            showCustomSnackBar(context, error.toString());
            break;
          case "ERROR_WRONG_PASSWORD":
          case "wrong-password":
            error = "Wrong email/password combination.";
            showCustomSnackBar(context, error.toString());
            break;
          case "ERROR_USER_NOT_FOUND":
          case "user-not-found":
            error = "No user found with this email.";
            showCustomSnackBar(context, error.toString());
            break;
          case "ERROR_USER_DISABLED":
          case "user-disabled":
            error = "User disabled.";
            showCustomSnackBar(context, error.toString());
            break;
          case "ERROR_TOO_MANY_REQUESTS":
          case "operation-not-allowed":
            error = "Too many requests to log into this account.";
            showCustomSnackBar(context, error.toString());
            break;
          case "ERROR_OPERATION_NOT_ALLOWED":
          case "operation-not-allowed":
            error = "Server error, please try again later.";
            showCustomSnackBar(context, error.toString());
            break;
          case "ERROR_INVALID_EMAIL":
          case "invalid-email":
            error = "Email address is invalid.";
            showCustomSnackBar(context, error.toString());
            break;
          default:
            error = "Login failed. Please try again.";
            showCustomSnackBar(context, error.toString());
            break;
        }
        print(error.toString());
        showCustomSnackBar(context, error.toString());
      } else {
        showCustomSnackBar(context, 'هناك مشكلة');
      }
    });
  }

  Future forgetPassword(
    context, {
    required String email,
  }) async {
    isLoading = true;
    update();
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then((value) async {
      isLoading = false;
      update();
      showCustomSnackBar(
          context, 'تم ارسال رابط لايميلك لاعادة تعيين كلمة المرور',
          isError: false);
      Get.offAndToNamed(RouteHelper.getLoginRoute());
    }).catchError((error) {
      isLoading = false;
      update();
      print(error.toString());
      showCustomSnackBar(context, error.toString());
    });
  }

  Future<void> createCometChatUserAndLogin(
      String uid, String email, String username) async {
    final user = cc.User(uid: uid, name: username);

    await cc.CometChat.createUser(user, AppConstants.COMETCHAT_AUTH_KEY,
        onSuccess: (user) async {
      print('Done creating!');
      print(user);
      await cc.CometChat.login(uid, AppConstants.COMETCHAT_AUTH_KEY,
          onSuccess: (cc.User user) {
        debugPrint("Login Successful : $user");
      }, onError: (cc.CometChatException e) {
        debugPrint("Login failed with exception:  ${e.message}");
      });
    }, onError: (cc.CometChatException? err) {
      print(err);
    });
  }

  Future userRegister(
    context, {
    String? identity,
    required String username,
    required String city,
    String? license_number,
    String? commercial_registration_number,
    String? bio,
    required String user_type,
    String? image,
    String? gender,
    required String phone,
    required String email,
    required String password,
  }) async {
    isLoading = true;
    update();

//store data on firebase
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user);
      createUser(
        context,
        identity: identity,
        username: username,
        city: city,
        license_number: license_number,
        commercial_registration_number: commercial_registration_number,
        bio: bio,
        phone: phone,
        email: email,
        image: image,
        user_type: user_type,
        gender: gender,
        uId: value.user!.uid,
      ).then((value2) async {
        isLoading = false;
        update();

       await createCometChatUserAndLogin(value.user!.uid, email, username);

        // Send a verification email
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await user.sendEmailVerification().then((value) {
            showCustomSnackBar(
                context, 'Registration Successfully, Verify Email and Login!',
                isError: false);
            Get.offAndToNamed(RouteHelper.getLoginRoute());
          });
        } else {
          showCustomSnackBar(context, 'User not found!');
        }

        // Get.offAndToNamed(RouteHelper.getInitialRoute(user_type: user_type));
      });
    }).catchError((error) {
      switch (error.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
          error = "Email already used. Go to login page.";
          print(error);
          showCustomSnackBar(context, error.toString());
          break;
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          error = "Wrong email/password combination.";
          showCustomSnackBar(context, error.toString());
          break;
        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          error = "No user found with this email.";
          showCustomSnackBar(context, error.toString());
          break;
        case "ERROR_USER_DISABLED":
        case "user-disabled":
          error = "User disabled.";
          showCustomSnackBar(context, error.toString());
          break;
        case "ERROR_TOO_MANY_REQUESTS":
        case "operation-not-allowed":
          error = "Too many requests to log into this account.";
          showCustomSnackBar(context, error.toString());
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
        case "operation-not-allowed":
          error = "Server error, please try again later.";
          showCustomSnackBar(context, error.toString());
          break;
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          error = "Email address is invalid.";
          showCustomSnackBar(context, error.toString());
          break;
        default:
          error = "Register failed. Please try again.";
          showCustomSnackBar(context, error.toString());
          break;
      }
      isLoading = false;
      update();
    });
  }

//function to create user
  Future createUser(
    context, {
    required identity,
    required String username,
    required String city,
    required license_number,
    required commercial_registration_number,
    required bio,
    required String user_type,
    String? image,
    String? gender,
    required String phone,
    required String email,
    required String uId,
  }) async {
    UserModel model = UserModel.withId(
      identity: identity,
      username: username,
      city: city,
      license_number: license_number,
      commercial_registration_number: commercial_registration_number,
      bio: bio,
      phone: phone,
      email: email,
      user_type: user_type,
      gender: gender,
      image: image ?? "null",
      id: uId,
      isVerfied: false,
      date: DateTime.now().toIso8601String(),
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId.toString())
        .set(model.toMap())
        .then((value) {
      print('Done');
    }).catchError((error) {
      //if something error in regiestration
      switch (error.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
          error = "Email already used. Go to login page.";
          print(error);
          showCustomSnackBar(context, error.toString());
          break;
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          error = "Wrong email/password combination.";
          showCustomSnackBar(context, error.toString());
          break;
        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          error = "No user found with this email.";
          showCustomSnackBar(context, error.toString());
          break;
        case "ERROR_USER_DISABLED":
        case "user-disabled":
          error = "User disabled.";
          showCustomSnackBar(context, error.toString());
          break;
        case "ERROR_TOO_MANY_REQUESTS":
        case "operation-not-allowed":
          error = "Too many requests to log into this account.";
          showCustomSnackBar(context, error.toString());
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
        case "operation-not-allowed":
          error = "Server error, please try again later.";
          showCustomSnackBar(context, error.toString());
          break;
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          error = "Email address is invalid.";
          showCustomSnackBar(context, error.toString());
          break;
        default:
          error = "Register failed. Please try again.";
          showCustomSnackBar(context, error.toString());
          break;
      }
      print(error.toString());
    });
  }

  Future signOut(context) async {
    print(storage.getString(AppConstants.USER_TYPE));
    storage
        .remove(
      AppConstants.USER_ID,
    )
        .then((value) async {
      storage.setString(AppConstants.IS_LOGIN, '0');
      userData = null;
      cc.CometChat.logout(
          onSuccess: (String sucess) {},
          onError: (cc.CometChatException err) {});
      storage.remove(AppConstants.USER_NAME);
      storage.remove(AppConstants.USER_TYPE);
      FirebaseAuth.instance.signOut();
      showCustomSnackBar(context, "تم تسجيل الخروج بنجاح!", isError: false);
      Get.offAndToNamed(RouteHelper.getLoginRoute());
    });
  }

  UserModel? userData;

  bool isgetDataLoading = true;

  Future<String> userInfo({userId}) async {
    isgetDataLoading = true;
    update();
    print(userId ?? storage.getString(AppConstants.USER_ID));
    try {
      final documentSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(userId ?? storage.getString(AppConstants.USER_ID))
          .get();

      userData = UserModel.fromMap(documentSnapshot.data()!);

      await storage.setString(AppConstants.USER_NAME, userData!.username!);
      await storage.setString(AppConstants.USER_TYPE, userData!.user_type!);
      isgetDataLoading = false;
      update();

      return userData!.user_type!;
    } catch (error) {
      isgetDataLoading = false;
      update();
      print(error.toString());
      throw error; // Rethrow the error to handle it higher up in the call stack if needed.
    }
  }

  Future updateUserInfo(context, UserModel model) async {
    isLoading = true;
    update();
    FirebaseFirestore.instance
        .collection("users")
        .doc(storage.getString(AppConstants.USER_ID))
        .set(model.toMap())
        .then((value) {
      userInfo(userId: storage.getString(AppConstants.USER_ID));
      isLoading = false;
      update();
      showCustomSnackBar(context, 'Profile Updated Successfully',
          isError: false);
    }).catchError((error) {
      isLoading = false;
      update();
      print(error.toString());
    });
  }

  void changePassword(
      context, String currentPassword, String newPassword) async {
    isLoading = true;
    update();
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: FirebaseAuth.instance.currentUser!.email!,
            password: currentPassword)
        .then((value) async {
      await value.user!.updatePassword(newPassword);
      showCustomSnackBar(context, 'password_changed_successfully',
          isError: false);
      Navigator.pop(context);
    }).catchError((err) {
      showCustomSnackBar(context, 'current_password_is_wrong');
    });
    isLoading = false;
    update();
  }

  removeUser(context) async {
    isLoading = true;
    update();
    final user = FirebaseAuth.instance.currentUser;
    await user!.delete().then((value) {
      isLoading = false;
      update();
      signOut(context);

      showCustomSnackBar(context, 'your_account_remove_successfully'.tr,
          isError: false);
    });
    isLoading = false;
    update();
    print('User account deleted');
    showCustomSnackBar(
        context, 'there_is_a_problem_on_removing_your_account'.tr);
  }
}
