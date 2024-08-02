import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants.dart';
import 'app_style.dart';
import 'reusable_text.dart';

showAlertDialog(
  BuildContext context, {
  required String message,
  String? buttonText,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(20.w).copyWith(
          bottom: 0.h,
        ),
        content: ReusableText(
          text: message,
          style: appStyle(
            18,
            Constants.kLight,
            FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              buttonText ?? "OK",
              style: appStyle(18, Constants.kGreyLight, FontWeight.w500),
            ),
          ),
        ],
      );
    },
  );
}
