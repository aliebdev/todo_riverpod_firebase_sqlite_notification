import 'package:flutter/material.dart';

import '../../../common/utils/constants.dart';
import '../../../common/widgets/spacers.dart';
import '../../auth/pages/login_page.dart';
import 'custom_otn_button.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constants.kHeight,
      width: Constants.kWidth,
      color: Constants.kBkLight,
      child: Container(
        height: Constants.kHeight,
        width: Constants.kWidth,
        color: Constants.kBkDark,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/todo.png"),
            const HeightSpacer(50),
            CustomOtnButton(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              ),
              text: "Login with a phone number",
              height: Constants.kHeight * .06,
              width: Constants.kWidth * .9,
            ),
          ],
        ),
      ),
    );
  }
}
