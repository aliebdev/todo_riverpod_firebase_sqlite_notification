// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo/common/helpers/db_helper.dart';
import 'package:todo/common/widgets/show_dialog.dart';

import '../../../common/routes/routes.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  final firebase = FirebaseAuth.instance;
  return AuthRepository(auth: firebase);
}

class AuthRepository {
  final FirebaseAuth auth;

  AuthRepository({required this.auth});

  void verifyOtp(
    BuildContext context, {
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: smsCodeId,
        smsCode: smsCode,
      );

      await auth.signInWithCredential(credential);

      if (!mounted) {
        return;
      }
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.home,
        (route) => false,
      );
    } on FirebaseAuth catch (e) {
      showAlertDialog(context, message: e.toString());
    }
  }

  void sendOtp(
    BuildContext context, {
    required String phone,
  }) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (phoneAuthCredential) async {
          await auth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          showAlertDialog(context, message: error.toString());
        },
        codeSent: (smsCodeId, resendCodeId) {
          DBHelper.createUser(1);
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.otp,
            (route) => false,
            arguments: {
              "phone": phone,
              "smsCodeId": smsCodeId,
            },
          );
        },
        codeAutoRetrievalTimeout: (smsCodeId) {},
      );
    } on FirebaseAuth catch (e) {
      showAlertDialog(context, message: e.toString());
    }
  }
}
