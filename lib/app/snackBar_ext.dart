import 'package:flutter/material.dart';
import 'package:school_app/app/size_extensions.dart';
import 'package:school_app/app/theme/app_colours.dart';

extension AppAlerts on BuildContext {
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(snackBarContent(
      message: message,
      context: this,
    ));
  }
}


SnackBar snackBarContent({
  Color color = AppColors.primaryColor,
  required String message,
  required BuildContext context,
  double w = double.infinity,
}) {
  return SnackBar(
    width: context.w * 0.9,
    backgroundColor: color,
    elevation: 5,
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    content: Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white)
      ),
    ),
  );
}
