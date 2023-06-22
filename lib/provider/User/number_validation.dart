import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NumberValidationProvider extends ChangeNotifier {
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  String? smsCode;
  String? verificationCode;
  final numberFormKey = GlobalKey<FormState>();

  Future<void> sendOTP() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: countryCodeController.text + numberController.text,
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (FirebaseAuthException error) {
        log("Verification failed $error");
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        log(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    log("OTP Sent to ${countryCodeController.text + numberController.text}");

    notifyListeners();
  }

  clearNumberField() {
    numberController.clear();
    notifyListeners();
  }
}
