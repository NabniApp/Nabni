import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/controller/contractor_controller.dart';

import 'package:new_nabni_app/view/widgets/custom_button.dart';
import 'package:new_nabni_app/view/widgets/custom_snackbar.dart';
import 'package:new_nabni_app/view/widgets/custom_text_field.dart';

class AddNewStepScreen extends StatefulWidget {
  final String id;
  const AddNewStepScreen({super.key, required this.id});

  @override
  State<AddNewStepScreen> createState() => _AddNewStepScreenState();
}

class _AddNewStepScreenState extends State<AddNewStepScreen> {
  DateTime startSelectedDate =
      DateTime.now(); // Initially set to the current date
  DateTime endSelectedDate =
      DateTime.now(); // Initially set to the current date
  TextEditingController nameStep = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController description = TextEditingController();

  Future<void> _selectDate(BuildContext context, startOrEnd) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startSelectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != startSelectedDate) {
      setState(() {
        if (startOrEnd == 'start') {
          startSelectedDate = picked;
          startDate.text = picked.toString();
        } else {
          endSelectedDate = picked;
          endDate.text = picked.toString();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 254, 253, 249),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: .7,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Color(0xff8B7C61),
              )),
          centerTitle: true,
          title: const Text(
            'إضافة خطوة جديدة',
            style: TextStyle(color: Color(0xff8B7C61),fontWeight: FontWeight.bold,fontSize: 17, fontFamily: 'Cairo'),
          ),
          actions: [],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).cardColor,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade200,
                          spreadRadius: 1,
                          blurRadius: 5)
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.list,
                        color: Color(0xff8B7C61),
                        size: 27,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'إنشاء خطوة جديدة',
                        style: TextStyle(
                            color: Color(0xff8B7C61),
                            fontFamily: 'Cairo',
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).cardColor,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade200,
                          spreadRadius: 1,
                          blurRadius: 5)
                    ],
                  ),
                  child: Column(children: [
                    CustomTextField(
                      hintText: 'اسم الخطوة',
                      controller: nameStep,
                      inputType: TextInputType.text,
                      showTitle: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
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
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 231, 231, 231),
                            style: BorderStyle.solid,
                            width: 1),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        _selectDate(context, 'start');
                      },
                      child: CustomTextField(
                        isEnabled: false,
                        hintText: 'تاريخ البدء',
                        controller: startDate,
                        inputType: TextInputType.text,
                        suffixIcon: IconButton(
                            onPressed: () {
                              _selectDate(context, 'start');
                            },
                            icon: const Icon(Icons.calendar_month)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
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
                        showTitle: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 231, 231, 231),
                              style: BorderStyle.solid,
                              width: 1),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        _selectDate(context, 'end');
                      },
                      child: CustomTextField(
                        isEnabled: false,
                        hintText: 'تاريخ الإنتهاء المتوقع',
                        controller: endDate,
                        inputType: TextInputType.text,
                        suffixIcon: IconButton(
                            onPressed: () {
                              _selectDate(context, 'end');
                            },
                            icon: const Icon(Icons.calendar_month)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
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
                        showTitle: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 231, 231, 231),
                              style: BorderStyle.solid,
                              width: 1),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextField(
                      hintText: 'الوصف',
                      controller: description,
                      inputType: TextInputType.multiline,
                      maxLines: 5,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
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
                      showTitle: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 231, 231, 231),
                            style: BorderStyle.solid,
                            width: 1),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GetBuilder<ContractorController>(builder: (controller) {
                      return controller.isLoading
                          ? CircularProgressIndicator()
                          : CustomButton(
                              buttonText: 'اضافة الخطوة',
                              onPressed: () {
                                _save(controller);
                              },
                            );
                    }),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _save(ContractorController controller) async {
    String _description = description.text.trim();
    String _name = nameStep.text.trim();

    if (_description.isEmpty) {
      showCustomSnackBar(context, 'Enter your step description!');
    } else if (_name.isEmpty) {
      showCustomSnackBar(context, 'Please enter step Name!');
    } else {
      controller
          .addNewStep(context,
              description: _description,
              name: _name,
              startDate: startSelectedDate,
              endDate: endSelectedDate,
              project_id: widget.id)
          .then((status) async {});
    }
  }
}
