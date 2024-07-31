import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/utils/constants.dart';
import '../../../common/widgets/app_style.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../common/widgets/reusable_text.dart';
import '../../../common/widgets/spacers.dart';
import '../../onboarding/widgets/custom_otn_button.dart';
import 'otp_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController phone = TextEditingController();

  Country country = Country(
    phoneCode: "1",
    countryCode: "US",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "USA",
    example: "USA",
    displayName: "United States",
    displayNameNoCountryCode: "US",
    e164Key: "",
  );

  @override
  void dispose() {
    phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Image.asset(
                  "assets/images/todo.png",
                  width: 300,
                ),
              ),
              const HeightSpacer(20),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 16.w),
                child: ReusableText(
                  text: "Please enter your phone number",
                  style: appStyle(
                    17,
                    Constants.kLight,
                    FontWeight.w500,
                  ),
                ),
              ),
              const HeightSpacer(20),
              Center(
                child: CustomTextField(
                  controller: phone,
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(14),
                    child: GestureDetector(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          countryListTheme: CountryListThemeData(
                            backgroundColor: Constants.kLight,
                            bottomSheetHeight: Constants.kHeight * .6,
                            // textStyle: ,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(Constants.kRadius),
                              topRight: Radius.circular(Constants.kRadius),
                            ),
                          ),
                          onSelect: (code) {
                            setState(() {
                              country = code;
                            });
                          },
                        );
                      },
                      child: ReusableText(
                        text: "${country.flagEmoji} + ${country.phoneCode}",
                        style: appStyle(
                          18,
                          Constants.kBkDark,
                          FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  hintText: "Enter phone number",
                  hintStyle: appStyle(16, Constants.kBkDark, FontWeight.w600),
                ),
              ),
              const HeightSpacer(20),
              Padding(
                padding: const EdgeInsets.all(10),
                child: CustomOtnButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OtpPage(),
                      ),
                    );
                  },
                  text: "Send Code",
                  width: Constants.kWidth * .9,
                  height: Constants.kHeight * .075,
                  color: Constants.kBkDark,
                  backgroundColor: Constants.kLight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
