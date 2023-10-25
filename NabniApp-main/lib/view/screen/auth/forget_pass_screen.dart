import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/controller/auth_controller.dart';
import 'package:new_nabni_app/utiles/app_constants.dart';
import 'package:new_nabni_app/utiles/route_helper.dart';
import 'package:new_nabni_app/view/widgets/custom_snackbar.dart';
import 'signup_client_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImageAsset.onBoardingImageBack),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Image.asset(
                            ImageAsset.appBarLogo,
                            width: 198,
                            // height: 305,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'هل نسيت كلمة المرور؟',
                          style: TextStyle(
                            color: Color(0xFF8B7C61),
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          style: TextStyle(fontSize: 14),
                          controller: emailController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 6),
                            prefixIcon: Icon(
                              Icons.mail,
                              color: Color(0xFF8B7C61),
                              size: 18,
                            ),
                            filled: true,
                            fillColor: Color(0xFFFEFDF9),
                            hintText: 'أدخل البريد الإلكتروني',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Color(0x1E15172B),
                                width: 1,
                              ),
                            ),
                          ),
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
                                    onPressed: () {
                                      _send(authController);
                                    },
                                    child: Text(
                                      'إرسال',
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
                          height: 20,
                        ),
                       
                      ],
                    ),
                  ),
                )),
          )),
    );
  }

  void _send(AuthController authController) async {
    String _email = emailController.text.trim();

    if (_email.isEmpty) {
      showCustomSnackBar(context, 'الرجاء إدخال البريد الإلكتروني');
    } else {
      authController
          .forgetPassword(context, email: _email)
          .then((status) async {});
    }
  }
}
