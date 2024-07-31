import 'package:flutter/material.dart';

import '../../../common/utils/constants.dart';
import '../../../common/widgets/app_style.dart';
import '../../../common/widgets/reusable_text.dart';

class CustomOtnButton extends StatelessWidget {
  const CustomOtnButton({
    super.key,
    required this.text,
    this.height,
    this.width,
    this.color = Constants.kLight,
    this.backgroundColor,
    this.onTap,
  });

  final String text;
  final double? height;
  final double? width;
  final Color color;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: color),
        ),
        child: Center(
          child: ReusableText(
            text: text,
            style: appStyle(
              18,
              color,
              FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
