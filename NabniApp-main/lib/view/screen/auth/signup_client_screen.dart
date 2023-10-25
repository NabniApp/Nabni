import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_nabni_app/controller/auth_controller.dart';
import 'package:new_nabni_app/utiles/app_constants.dart';
import 'package:new_nabni_app/utiles/route_helper.dart';
import 'package:new_nabni_app/view/widgets/custom_snackbar.dart';

import 'signup_supplier_screen.dart';

class SignUpClientScreen extends StatefulWidget {
  const SignUpClientScreen({Key? key}) : super(key: key);

  @override
  _SignUpClientScreenState createState() => _SignUpClientScreenState();
}

class _SignUpClientScreenState extends State<SignUpClientScreen> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController idController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  TextEditingController companyBioController = new TextEditingController();

  String? cityselect;

  String? genderselect;

  bool agreedToTerms = false;

  File? image;
  var picker = ImagePicker();
  bool isImageLoading = false;

  Future<void> getImage() async {
    isImageLoading = true;
    setState(() {});
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
    }

    isImageLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            if (image != null)
              CircleAvatar(
                radius: 40,
                backgroundImage: FileImage(image!),
              ),
            if (image == null)
              Stack(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage:
                        AssetImage('assets/images/placeholder.jpg'),
                  ),
                  InkWell(
                    onTap: () {
                      getImage();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 40,
                      child: Icon(
                        Icons.add,
                        size: 25,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: usernameController,
              style: TextStyle(fontSize: 14),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 6),
                prefixIcon:
                    Icon(Icons.person, color: Color(0xFF8B7C61), size: 18),
                filled: true,
                fillColor: Color(0xFFFEFDF9),
                hintText: 'أدخل الأسم الكامل',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Color(0x1E15172B), width: 1),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: emailController,
              style: TextStyle(fontSize: 14),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 6),
                prefixIcon:
                    Icon(Icons.mail, color: Color(0xFF8B7C61), size: 18),
                filled: true,
                fillColor: Color(0xFFFEFDF9),
                hintText: 'أدخل البريد الإلكتروني',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Color(0x1E15172B), width: 1),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: phoneController,
              style: TextStyle(fontSize: 14),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'\d+'))
              ],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 6),
                prefixIcon:
                    Icon(Icons.phone, color: Color(0xFF8B7C61), size: 18),
                filled: true,
                fillColor: Color(0xFFFEFDF9),
                hintText: 'أدخل رقم الهاتف',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Color(0x1E15172B), width: 1),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: idController,
              style: TextStyle(fontSize: 14),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'\d+'))
              ],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 6),
                prefixIcon:
                    Icon(Icons.badge, color: Color(0xFF8B7C61), size: 18),
                filled: true,
                fillColor: Color(0xFFFEFDF9),
                hintText: 'أدخل رقم الهوية',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Color(0x1E15172B), width: 1),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: passController,
              style: TextStyle(fontSize: 14),
              obscureText: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 6),
                prefixIcon:
                    Icon(Icons.lock, color: Color(0xFF8B7C61), size: 18),
                filled: true,
                fillColor: Color(0xFFFEFDF9),
                hintText: 'أدخل كلمة المرور',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Color(0x1E15172B), width: 1),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  hint: Row(
                    children: [
                      Icon(
                        Icons.location_city,
                        size: 20,
                        color: Color(0xFF8B7C61),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          'المدينة',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8B7C61),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  items: AppConstants.cities
                      .map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF8B7C61),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  value: cityselect,
                  onChanged: (value) {
                    setState(() {
                      cityselect = value;
                    });
                  },
                  buttonStyleData: ButtonStyleData(
                    height: 50,
                    width: 160,
                    padding: const EdgeInsets.only(left: 14, right: 14),
                    decoration: BoxDecoration(
                      color: Color(0xFFFEFDF9),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        width: 1,
                        color: Color(0x1E15172B),
                      ),
                    ),
                    elevation: 2,
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(Icons.keyboard_arrow_down_outlined,
                        color: Color(0xFF8B7C61)),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200,
                    decoration: BoxDecoration(
                      color: Color(0xFFFEFDF9),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        width: 1,
                        color: Color(0x1E15172B),
                      ),
                    ),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(5),
                      thickness: MaterialStateProperty.all(6),
                      thumbVisibility: MaterialStateProperty.all(true),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                    padding: EdgeInsets.only(left: 14, right: 14),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  hint: Row(
                    children: [
                      Icon(
                        Icons.group,
                        size: 20,
                        color: Color(0xFF8B7C61),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          'الجنس',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8B7C61),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  items: AppConstants.gender
                      .map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF8B7C61),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  value: genderselect,
                  onChanged: (value) {
                    setState(() {
                      genderselect = value;
                    });
                  },
                  buttonStyleData: ButtonStyleData(
                    height: 50,
                    width: 160,
                    padding: const EdgeInsets.only(left: 14, right: 14),
                    decoration: BoxDecoration(
                      color: Color(0xFFFEFDF9),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        width: 1,
                        color: Color(0x1E15172B),
                      ),
                    ),
                    elevation: 2,
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(Icons.keyboard_arrow_down_outlined,
                        color: Color(0xFF8B7C61)),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200,
                    decoration: BoxDecoration(
                      color: Color(0xFFFEFDF9),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        width: 1,
                        color: Color(0x1E15172B),
                      ),
                    ),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(5),
                      thickness: MaterialStateProperty.all(6),
                      thumbVisibility: MaterialStateProperty.all(true),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                    padding: EdgeInsets.only(left: 14, right: 14),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                  value: agreedToTerms,
                  onChanged: (bool? value) {
                    setState(() {
                      agreedToTerms = value!;
                    });
                  },
                ),
                
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: 'إنشائك لحساب يعني أنك توافق على ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontFamily: 'Cairo',
                      ),
                      children: [
                        TextSpan(
                          text: "شروط المستخدم و سياسة الخصوصية",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF426E9B),
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.toNamed(RouteHelper.getPrivacyRoute());
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            GetBuilder<AuthController>(builder: (authController) {
              return authController.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: agreedToTerms
                            ? () {
                                _register(authController);
                              }
                            : null,
                        child: Text(
                          "إنشاء الحساب",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFFDFCF9),
                            fontSize: 18,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(0),
                            ),
                          ),
                          minimumSize: Size(300, 45),
                          backgroundColor: Color(0xFF8B7C61),
                        ),
                      ),
                    );
            }),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'هل لديك حساب؟',
                  style: TextStyle(
                    fontSize: 14, 
                    color: Color.fromARGB(255, 4, 4, 4),
                  ),
                ),
                TextButton(
                  child: const Text(
                    'سجل دخولك',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                      color: Color(0xFF426E9B),
                    ),
                  ),
                  onPressed: () {
                    Get.toNamed(RouteHelper.getLoginRoute());
                  },
                ),
              ],
            ),
          const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  void _register(AuthController authController) async {
    String _username = usernameController.text.trim();
    String _email = emailController.text.trim();
    String _number = phoneController.text.trim();
    String _password = passController.text.trim();
    String bioRegister = companyBioController.text.trim();
    String identity = idController.text.trim();

    if (_username.isEmpty) {
      showCustomSnackBar(context, 'الرجاء إدخال الإسم');
    } else if (_email.isEmpty) {
      showCustomSnackBar(context, 'الرجاء إدخال البريد الإلكتروني');
    } else if (identity.isEmpty) {
      showCustomSnackBar(context, 'الرجاء إدخال رقم الهوية');
    } else if (!GetUtils.isEmail(_email)) {
      showCustomSnackBar(context, 'الرجاء إدخال بريد إلكتروني صحيح');
    } else if (_number.isEmpty) {
      showCustomSnackBar(context, 'الرجاء إدخال رقم الهاتف');
    } else if (cityselect == null) {
      showCustomSnackBar(context, 'الرجاء إختيار المدينة');
    } else if (genderselect == null) {
      showCustomSnackBar(context, 'الرجاء إختيار الجنس');
    } else if (_password.isEmpty) {
      showCustomSnackBar(context, 'الرجاء إدخال كلمة المرور');
    } else if (_password.length < 6) {
      showCustomSnackBar(context, 'يرجى إدخال كلمة مرور مؤلفة من 7 أحرف أو أكثر');
    } else {
      if (image != null) {
        await authController.uploadImage(image!).then((image_url) async {
          authController
              .userRegister(context,
                  username: _username,
                  user_type: AppConstants.userTypes[2],
                  phone: _number,
                  identity: identity,
                  email: _email,
                  city: cityselect!,
                  gender: genderselect!,
                  password: _password)
              .then((status) async {});
        });
      } else {
        authController
            .userRegister(context,
                username: _username,
                user_type: AppConstants.userTypes[2],
                phone: _number,
                identity: identity,
                email: _email,
                city: cityselect!,
                gender: genderselect!,
                password: _password)
            .then((status) async {});
      }
    }
  }
}
