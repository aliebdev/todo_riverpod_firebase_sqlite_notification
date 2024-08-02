// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:todo/features/auth/controllers/auth_controller.dart';

import '../../../common/utils/constants.dart';
import '../../../common/widgets/app_style.dart';
import '../../../common/widgets/reusable_text.dart';
import '../../../common/widgets/spacers.dart';

class OtpPage extends ConsumerWidget {
  const OtpPage({
    super.key,
    required this.smsCodeId,
    required this.phone,
  });

  final String smsCodeId;
  final String phone;

  void verifyOtpCode(BuildContext context, WidgetRef ref, String smsCode) {
    ref.read(authControllerProvider).verifyOtp(
          context,
          smsCodeId: smsCodeId,
          smsCode: smsCode,
          mounted: true,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HeightSpacer(Constants.kHeight * .12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Image.asset(
                  "assets/images/todo.png",
                  width: Constants.kWidth * .5,
                ),
              ),
              const HeightSpacer(26),
              ReusableText(
                text: "Enter your otp code",
                style: appStyle(
                  18,
                  Constants.kLight,
                  FontWeight.bold,
                ),
              ),
              const HeightSpacer(26),
              Pinput(
                length: 6,
                showCursor: true,
                onCompleted: (value) {
                  if (value.length == 6) {
                    verifyOtpCode(context, ref, value);
                  }
                },
                onSubmitted: (value) {
                  if (value.length == 6) {
                    verifyOtpCode(context, ref, value);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
