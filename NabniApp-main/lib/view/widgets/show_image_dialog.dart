import 'package:flutter/material.dart';
import 'package:new_nabni_app/view/widgets/custom_button.dart';

showImageDialog(BuildContext context, String url) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
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
              Image.network(
                url,
                width: 150,
                height: 150,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                margin: const EdgeInsets.all(20.0),
                buttonText: 'حسنا',
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      );
    },
  );
}
