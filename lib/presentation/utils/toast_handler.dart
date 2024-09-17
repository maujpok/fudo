import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fudo/app/ui_style.dart';

class ToastHandler implements Fluttertoast {
  ToastHandler._();

  static void showSuccessToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.successColor,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16.0,
    );
  }

  static void showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.errorColor,
      textColor: Colors.white,
    );
  }

  static void showWarningToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.warningColor,
      textColor: Colors.black,
    );
  }
}
