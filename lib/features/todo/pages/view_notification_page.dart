// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/common/utils/constants.dart';
import 'package:todo/common/widgets/app_style.dart';
import 'package:todo/common/widgets/reusable_text.dart';
import 'package:todo/common/widgets/spacers.dart';

class ViewNotificationPage extends StatelessWidget {
  const ViewNotificationPage({
    super.key,
    this.payload,
  });

  final String? payload;

  @override
  Widget build(BuildContext context) {
    var title = payload!.split("|")[0];
    var desc = payload!.split("|")[1];
    var date = payload!.split("|")[2];
    var start = payload!.split("|")[3];
    var end = payload!.split("|")[4];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 20.h,
              ),
              child: Container(
                height: Constants.kHeight * .7,
                width: Constants.kWidth,
                padding: EdgeInsets.all(12.h),
                decoration: BoxDecoration(
                  color: Constants.kBkLight,
                  borderRadius: BorderRadius.circular(Constants.kRadius),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                      text: "Reminder",
                      style: appStyle(
                        40,
                        Constants.kLight,
                        FontWeight.bold,
                      ),
                    ),
                    const HeightSpacer(5),
                    Container(
                      width: Constants.kWidth,
                      padding: const EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                          color: Constants.kYellow,
                          borderRadius: BorderRadius.circular(9.h)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ReusableText(
                            text: "Today",
                            style: appStyle(
                              14,
                              Constants.kBkDark,
                              FontWeight.bold,
                            ),
                          ),
                          const WidthSpacer(15),
                          ReusableText(
                            text: "From : $start To : $end",
                            style: appStyle(
                              15,
                              Constants.kBkDark,
                              FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const HeightSpacer(10),
                    ReusableText(
                      text: title,
                      style: appStyle(
                        30,
                        Constants.kBkDark,
                        FontWeight.bold,
                      ),
                    ),
                    Text(
                      desc,
                      maxLines: 8,
                      style: appStyle(
                        16,
                        Constants.kLight,
                        FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 12,
              top: -10,
              child: Image.asset(
                "assets/images/bell.png",
                width: 70.w,
                height: 70.h,
              ),
            ),
            Positioned(
              bottom: -Constants.kHeight * .143,
              left: 0,
              right: 0,
              child: Image.asset(
                "assets/images/notif.png",
                width: Constants.kWidth,
                height: Constants.kHeight * .6,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
