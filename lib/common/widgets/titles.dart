import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/constants.dart';
import 'app_style.dart';
import 'reusable_text.dart';
import 'spacers.dart';

class BottomTitles extends StatelessWidget {
  const BottomTitles({
    super.key,
    required this.text,
    required this.text2,
    this.color,
  });

  final String text;
  final String text2;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Constants.kWidth,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Consumer(
              builder: (context, ref, child) {
                return Container(
                  height: 80,
                  width: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Constants.kRadius),
                    color: color ?? Constants.kGreen,
                  ),
                );
              },
            ),
            const WidthSpacer(15),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                    text: text,
                    style: appStyle(
                      24,
                      Constants.kLight,
                      FontWeight.bold,
                    ),
                  ),
                  const HeightSpacer(10),
                  ReusableText(
                    text: text2,
                    style: appStyle(
                      12,
                      Constants.kLight,
                      FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
