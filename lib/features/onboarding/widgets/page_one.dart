import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/utils/constants.dart';
import '../../../common/widgets/app_style.dart';
import '../../../common/widgets/reusable_text.dart';
import '../../../common/widgets/spacers.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constants.kHeight,
      width: Constants.kWidth,
      color: Constants.kBkDark,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/todo.png"),
          const HeightSpacer(100),
          Column(
            children: [
              ReusableText(
                text: "Todo with Riverpod",
                style: appStyle(30, Constants.kLight, FontWeight.w600),
              ),
              const HeightSpacer(10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Text(
                  "Welcome!! Do you want to create a task and ease",
                  textAlign: TextAlign.center,
                  style: appStyle(16, Constants.kGreyLight, FontWeight.normal),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
