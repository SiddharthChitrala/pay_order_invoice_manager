import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';

import '../res/colors.dart';


class Utils {

  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static const Duration fadeInDuration = Duration(seconds: 2);
  static const Duration initialDelay = Duration(milliseconds: 500);

static snackBar(String message, BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: AppColors.errormsg,
    content: Text(message),
  ));
}



  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          message: message,
          title: "Error",
          backgroundColor:AppColors.errormsg,
          messageColor: AppColors.blackColor,
          duration: const Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
          forwardAnimationCurve: Curves.decelerate,
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          padding: const EdgeInsets.all(15),
          borderRadius: BorderRadius.circular(25),
          reverseAnimationCurve: Curves.easeInOut,
          icon: const Icon(
            Icons.error_outlined,
            size: 28,
            color: AppColors.whiteColor,
          ),
        )..show(context));
  }
  
}
