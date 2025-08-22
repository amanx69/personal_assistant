import 'package:app/helper/fonts.dart';
import 'package:flutter/material.dart';

class Alert {
  
  static void showToast(BuildContext context, String message, {Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message,style: CustomFonts.alertbox,),
        backgroundColor: color ?? Colors.black87,
        behavior: SnackBarBehavior.fixed,
        duration: Duration(seconds: 2),
      ),
    );
  }
}