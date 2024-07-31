// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeightSpacer extends StatelessWidget {
  const HeightSpacer(
    this.height, {
    super.key,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height.h);
  }
}

class WidthSpacer extends StatelessWidget {
  const WidthSpacer(
    this.width, {
    super.key,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: width.w);
  }
}
