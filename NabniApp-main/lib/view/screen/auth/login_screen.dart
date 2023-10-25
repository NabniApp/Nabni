import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/controller/auth_controller.dart';
import 'package:new_nabni_app/utiles/app_constants.dart';
import 'package:new_nabni_app/utiles/route_helper.dart';
import 'package:new_nabni_app/view/widgets/custom_snackbar.dart';
import 'signup_client_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

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
                          'تسجيل دخول',
                          style: TextStyle(
                            color: Color(0xFF8B7C61),
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
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
                        TextField(
                          controller: passController,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 6),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Color(0xFF8B7C61),
                              size: 18,
                            ),
                            filled: true,
                            fillColor: Color(0xFFFEFDF9),
                            hintText: 'أدخل كلمة المرور',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Get.toNamed(RouteHelper.getForgetPasswordRoute());
                              },
                              child: const Text(
                                'هل نسيت كلمة المرور؟',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color(0xFF426E9B),
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 1,
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
                                      _login(authController);
                                    },
                                    child: Text(
                                      'تسجيل الدخول',
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
                              'ليس لديك حساب؟',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 4, 4, 4),
                              ),
                            ),
                            TextButton(
                              child: const Text(
                                'سجل الآن',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 14,
                                  color: Color(0xFF426E9B),
                                ),
                              ),
                              onPressed: () {
                                Get.toNamed(RouteHelper.getRegisterRoute());
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
          )),
    );
  }

  void _login(AuthController authController) async {
    String _email = emailController.text.trim();
    String _password = passController.text.trim();

    if (_email.isEmpty) {
      showCustomSnackBar(context, 'أدخل البريد الإلكتروني');
    } else if (_password.isEmpty) {
      showCustomSnackBar(context, 'أدخل كلمة المرور');
    } else if (_password.length < 6) {
      showCustomSnackBar(context, 'يرجى إدخال كلمة مرور مؤلفة من 7 أحرف أو أكثر');
    } else {
      authController
          .userLogin(context, email: _email, password: _password)
          .then((status) async {});
    }
  }
}
