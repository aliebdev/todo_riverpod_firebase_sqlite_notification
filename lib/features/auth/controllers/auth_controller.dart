import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo/features/auth/repository/auth_repository.dart';

part 'auth_controller.g.dart';

@riverpod
AuthController authController(AuthControllerRef ref) {
  final repo = ref.watch(authRepositoryProvider);
  return AuthController(repo);
}

class AuthController {
  final AuthRepository authRepository;

  AuthController(this.authRepository);

  void verifyOtp(
    BuildContext context, {
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
  }) {
    authRepository.verifyOtp(
      context,
      smsCodeId: smsCodeId,
      smsCode: smsCode,
      mounted: mounted,
    );
  }

  void sendSms(
    BuildContext context, {
    required String phone,
  }) {
    authRepository.sendOtp(context, phone: phone);
  }
}
