// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:todo/common/widgets/app_style.dart';
import 'package:todo/common/widgets/reusable_text.dart';
import 'package:todo/common/widgets/spacers.dart';

import '../../../common/utils/constants.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({
    super.key,
    this.color,
    this.title,
    this.description,
    this.start,
    this.end,
    this.editWidget,
    this.delete,
    this.switcher,
  });

  final Color? color;
  final String? title;
  final String? description;
  final String? start;
  final String? end;
  final Widget? editWidget;
  final VoidCallback? delete;
  final Widget? switcher;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(8.h),
            width: Constants.kWidth,
            decoration: BoxDecoration(
              color: Constants.kGreyLight,
              borderRadius: BorderRadius.circular(Constants.kRadius),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 80,
                      width: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Constants.kRadius),
                        color: color,
                      ),
                    ),
                    const WidthSpacer(15),
                    Padding(
                      padding: EdgeInsets.all(8.h),
                      child: SizedBox(
                        width: Constants.kWidth * .6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                              text: title ?? "Title",
                              style: appStyle(
                                18,
                                Constants.kLight,
                                FontWeight.bold,
                              ),
                            ),
                            const HeightSpacer(3),
                            ReusableText(
                              text: description ?? "Description",
                              style: appStyle(
                                12,
                                Constants.kLight,
                                FontWeight.bold,
                              ),
                            ),
                            const HeightSpacer(3),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: Constants.kWidth * .3,
                                  height: 25.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: .3,
                                      color: Constants.kGreyDk,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        Constants.kRadius),
                                    color: Constants.kBkDark,
                                  ),
                                  child: Center(
                                    child: ReusableText(
                                      text: "$start | $end",
                                      style: appStyle(
                                        12,
                                        Constants.kLight,
                                        FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                                const WidthSpacer(20),
                                Row(
                                  children: [
                                    SizedBox(
                                      child: editWidget,
                                    ),
                                    const WidthSpacer(20),
                                    GestureDetector(
                                      onTap: delete,
                                      child: const Icon(
                                        MaterialCommunityIcons.delete_circle,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 0.h),
                  child: switcher,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
