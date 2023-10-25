import 'package:flutter/material.dart';
import 'package:new_nabni_app/core/constant/appcolors.dart';

class CustomIvoiceButton extends StatelessWidget {
  const CustomIvoiceButton(
      {Key? key, required this.buttonText, required this.onPressed})
      : super(key: key);
  final String buttonText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.symmetric(vertical: 5),
      color: AppColors.primaryColor,
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(
            color: Color(0xFFFEFDF9),
            fontSize: 18,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
