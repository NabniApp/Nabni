import 'package:flutter/material.dart';
import 'package:new_nabni_app/utiles/app_constants.dart';
import 'package:new_nabni_app/view/screen/auth/signup_contractor_screen.dart';

import 'signup_client_screen.dart';
import 'signup_supplier_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final List<String> city = [
    'مكة',
  ];
  String? cityselect;

  final List<String> gender = [
    'أنثى',
    'ذكر',
  ];
  String? genderselect;

  bool agreedToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageAsset.onBoardingImageBack),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Image.asset(
                  ImageAsset.appBarLogo,
                  width: 198,
                  // height: 100,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'إنشاء حساب',
                  style: TextStyle(
                      color: Color(0xFF8B7C61),
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      fontFamily: 'Cairo'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: DefaultTabController(
                    length: 3,
                    child: Column(
                      children: [
                        Container(
                          height: 45,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 254, 253, 249),
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: Color.fromARGB(
                                  255, 239, 237, 237), // لون الحدود
                              width: 1,
                            ),
                          ),
                          child: TabBar(
                            indicator: BoxDecoration(
                              color: Color.fromARGB(255, 139, 124, 97),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            labelColor: Color.fromARGB(255, 255, 255, 255),
                            unselectedLabelColor:
                                Color.fromARGB(255, 139, 124, 97),
                            labelStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                            ),
                            unselectedLabelStyle: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Cairo',
                            ),
                            tabs: const [
                              Tab(text: 'مورد'),
                              Tab(text: 'مقاول'),
                              Tab(text: 'عميل'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20,),
                        const Expanded(
                          child: TabBarView(
                            children: <Widget>[
                              SignUpSupplierScreen(),
                              SignUpContractorScreen(),
                              SignUpClientScreen(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
