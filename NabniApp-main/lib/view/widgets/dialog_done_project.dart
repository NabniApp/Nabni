import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_nabni_app/data/model/user_model.dart';
import 'package:new_nabni_app/utiles/route_helper.dart';
import 'package:new_nabni_app/view/widgets/custom_button.dart';

showDoneProjectDialog(
    BuildContext context, UserModel contractor, String project_id) async {
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
                SizedBox(
                  height: 20,
                ),
                Text(
                  ' إنهاء المشروع',
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'عزيزي العميل أود أن أعبر لك عن امتناني على الفرصة التي منحتها لي للعمل معك في مشروعك. لقد كانت تجربة رائعة وممتعة بالنسبة لي. أتطلع إلى فرصة العمل معك مرة أخرى في المستقبل.',
                  style: TextStyle(fontSize: 17, fontFamily: 'Cairo'),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  margin: const EdgeInsets.all(10.0),
                  buttonText: 'إنهاء',
                  onPressed: () {
                    Navigator.pop(context);
                    Get.toNamed(RouteHelper.getAddContractorReviewRoute(
                        contractor, project_id));
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
