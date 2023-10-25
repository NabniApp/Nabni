import 'package:flutter/material.dart';

void showCustomSnackBar(context, String message, {bool isError = true}) {
  if (message != null && message.isNotEmpty) {
    ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
      dismissDirection: DismissDirection.horizontal,
      margin: EdgeInsets.all(10),
      duration: Duration(seconds: 3),
      backgroundColor: isError ? Colors.red : Colors.green,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      content: Text(message,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 14,
          )),
    ));
  }
}
