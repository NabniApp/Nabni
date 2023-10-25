import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/controller/auth_controller.dart';
import 'package:new_nabni_app/data/model/user_model.dart';
import 'package:new_nabni_app/utiles/app_constants.dart';
import 'package:new_nabni_app/utiles/route_helper.dart';
import 'package:new_nabni_app/view/widgets/custom_button.dart';
import 'package:new_nabni_app/view/widgets/custom_snackbar.dart';
import 'package:new_nabni_app/view/widgets/custom_text_field.dart';
import 'package:new_nabni_app/view/widgets/dialog_done_project.dart';

class EditSupplierProfileScreen extends StatefulWidget {
  UserModel model;
  EditSupplierProfileScreen({Key? key, required this.model}) : super(key: key);
  @override
  State<EditSupplierProfileScreen> createState() =>
      _EditSupplierProfileScreenState();
}

class _EditSupplierProfileScreenState extends State<EditSupplierProfileScreen> {
  TextEditingController _usernameameController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _companyBioController = new TextEditingController();

  TextEditingController _licienceController = TextEditingController();
  TextEditingController _commercialRegisterController = TextEditingController();
  bool _isObscure = true;

  final formKey = GlobalKey<FormState>();
  String? cityselect;

  @override
  void initState() {
    _usernameameController = TextEditingController(text: widget.model.username);
    _commercialRegisterController =
        TextEditingController(text: widget.model.bio);
    _emailController = TextEditingController(text: widget.model.email);
    _phoneController = TextEditingController(text: widget.model.phone);

    _typeController = TextEditingController(text: 'بلاط');
    _licienceController =
        TextEditingController(text: widget.model.license_number);
    _commercialRegisterController = TextEditingController(
        text: widget.model.commercial_registration_number);
    _companyBioController = TextEditingController(text: widget.model.bio);

    cityselect = widget.model.city;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: .7,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xff8B7C61),
                )),
            title: Text(
              'تعديل البيانات',
              style: TextStyle(color: Color(0xff8B7C61),fontWeight: FontWeight.bold,fontSize: 17, fontFamily: 'Cairo'),
            ),
            actions: [
             
            ],
          ),
          backgroundColor: Color.fromARGB(255, 254, 253, 249),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 5,
                            spreadRadius: 1)
                      ],
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 60.0,
                            ),
                            CustomTextField(
                              hintText: 'الإسم',
                              controller: _usernameameController,
                              inputType: TextInputType.text,
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    style: BorderStyle.solid,
                                    width: 10),
                              ),
                              activeBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    style: BorderStyle.solid,
                                    width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 231, 231, 231),
                                    style: BorderStyle.solid,
                                    width: 1),
                              ),
                              divider: true,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            CustomTextField(
                              hintText: 'رقم الهاتف',
                              controller: _phoneController,
                              inputType: TextInputType.number,
                              prefixIcon: Icon(Icons.phone),
                              isNumber: true,
                              divider: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    style: BorderStyle.solid,
                                    width: 10),
                              ),
                              activeBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    style: BorderStyle.solid,
                                    width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 231, 231, 231),
                                    style: BorderStyle.solid,
                                    width: 1),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            CustomTextField(
                              hintText: 'البريد الإلكتروني',
                              controller: _emailController,
                              inputType: TextInputType.emailAddress,
                              prefixIcon: Icon(Icons.email),
                              isEnabled: false,
                              divider: false,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    style: BorderStyle.solid,
                                    width: 10),
                              ),
                              activeBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    style: BorderStyle.solid,
                                    width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 231, 231, 231),
                                    style: BorderStyle.solid,
                                    width: 1),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
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
                                      .map((String item) =>
                                          DropdownMenuItem<String>(
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
                                    padding: const EdgeInsets.only(
                                        left: 14, right: 14),
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
                                    icon: Icon(
                                        Icons.keyboard_arrow_down_outlined,
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
                                      thumbVisibility:
                                          MaterialStateProperty.all(true),
                                    ),
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                    padding:
                                        EdgeInsets.only(left: 14, right: 14),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            // CustomTextField(
                            //   hintText: 'النوع',
                            //   controller: _typeController,
                            //   inputType: TextInputType.text,
                            //   prefixIcon: Icon(Icons.location_city),
                            //   divider: true,
                            //   border: OutlineInputBorder(
                            //     borderSide: BorderSide(
                            //         color: Theme.of(context).primaryColor,
                            //         style: BorderStyle.solid,
                            //         width: 10),
                            //   ),
                            //   activeBorder: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(5),
                            //     borderSide: BorderSide(
                            //         color: Theme.of(context).primaryColor,
                            //         style: BorderStyle.solid,
                            //         width: 2),
                            //   ),
                            //   enabledBorder: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(5),
                            //     borderSide: BorderSide(
                            //         color: Color.fromARGB(255, 231, 231, 231),
                            //         style: BorderStyle.solid,
                            //         width: 1),
                            //   ),
                            // ),
                            // const SizedBox(
                            //   height: 10.0,
                            // ),
                            CustomTextField(
                              hintText: 'الرخصة المهنية',
                              controller: _licienceController,
                              inputType: TextInputType.text,
                              prefixIcon: Icon(Icons.location_city),
                              divider: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    style: BorderStyle.solid,
                                    width: 10),
                              ),
                              activeBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    style: BorderStyle.solid,
                                    width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 231, 231, 231),
                                    style: BorderStyle.solid,
                                    width: 1),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            CustomTextField(
                              hintText: 'السجل التجاري',
                              controller: _commercialRegisterController,
                              inputType: TextInputType.text,
                              prefixIcon: Icon(Icons.location_city),
                              divider: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    style: BorderStyle.solid,
                                    width: 10),
                              ),
                              activeBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    style: BorderStyle.solid,
                                    width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 231, 231, 231),
                                    style: BorderStyle.solid,
                                    width: 1),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            CustomTextField(
                              hintText: 'اكتب نبذة عن الشركة',
                              controller: _companyBioController,
                              inputType: TextInputType.multiline,
                              maxLines: 2,
                              prefixIcon: Icon(Icons.compare_rounded),
                              divider: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    style: BorderStyle.solid,
                                    width: 10),
                              ),
                              activeBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    style: BorderStyle.solid,
                                    width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 231, 231, 231),
                                    style: BorderStyle.solid,
                                    width: 1),
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            GetBuilder<AuthController>(builder: (auth) {
                              return auth.isLoading
                                  ? CircularProgressIndicator()
                                  : CustomButton(
                                      buttonText: 'حفظ',
                                      onPressed: () {
                                        _update(auth);
                                      },
                                    );
                            }),
                            const SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                        if (widget.model.image == 'null')
                          Positioned(
                            top: -60,
                            left: 0,
                            right: 0,
                            child: CircleAvatar(
                                radius: 50,
                                backgroundImage: AssetImage(
                                    'assets/images/placeholder.jpg')),
                          ),
                        if (widget.model.image != 'null')
                          Positioned(
                            top: -60,
                            left: 0,
                            right: 0,
                            child: CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    NetworkImage(widget.model.image!)),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  void _update(AuthController authController) async {
    String _username = _usernameameController.text.trim();
    String _email = _emailController.text.trim();
    String _number = _phoneController.text.trim();
    String licenceNum = _licienceController.text.trim();
    String commercialRegister = _commercialRegisterController.text.trim();
    String bioRegister = _companyBioController.text.trim();

    if (_username.isEmpty) {
      showCustomSnackBar(context, 'الرجاء إدخال الإسم');
    } else if (_email.isEmpty) {
      showCustomSnackBar(context, 'الرجاء إدخال البريد الإلكتروني');
    } else if (licenceNum.isEmpty) {
      showCustomSnackBar(context, 'الرجاء إدخال رقم الرخصة المهنية');
    } else if (commercialRegister.isEmpty) {
      showCustomSnackBar(context, 'الرجاء إدخال رقم السجل التجاري');
    } else if (!GetUtils.isEmail(_email)) {
      showCustomSnackBar(context, 'الرجاء إدخال بريد إلكتروني صحيح');
    } else if (_number.isEmpty) {
      showCustomSnackBar(context, 'الرجاء إدخال رقم الهاتف');
    } else if (licenceNum.isEmpty) {
      showCustomSnackBar(context, 'الرجاء إدخال رقم الرخصة المهنية');
    } else if (bioRegister.isEmpty) {
      showCustomSnackBar(context, 'الرجاء إدخال نبذة عنك');
    } else if (cityselect == null) {
      showCustomSnackBar(context, 'الرجاء إختيار المدينة');
    } else {
      UserModel data = UserModel.withId(
          id: widget.model.id,
          username: _username,
          license_number: licenceNum,
          commercial_registration_number: commercialRegister,
          user_type: AppConstants.userTypes[0],
          phone: _number,
          email: _email,
          city: cityselect,
          bio: bioRegister);

      authController.updateUserInfo(context, data).then((value) {
        Navigator.pop(context);
      });
    }
  }
}
