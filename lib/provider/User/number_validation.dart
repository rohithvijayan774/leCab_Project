import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lecab/Views/splash_screen.dart';

class UserDetailsProvider extends ChangeNotifier {
  //Number Details

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

  //Name Details

  TextEditingController userFirstNameController = TextEditingController();
  TextEditingController userSurNameController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  final userNameFormKey = GlobalKey<FormState>();

  clearNameFields() {
    userFirstNameController.clear();
    userSurNameController.clear();
    notifyListeners();
  }

  signOut(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          // content: Text("Do you want to SignOut?"),
          title: const Text(
            'Do you want to SignOut?',
            style:
                TextStyle(fontFamily: 'SofiaPro', fontWeight: FontWeight.w600),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 17, fontFamily: "SofiaPro"),
              ),
            ),
            TextButton(
              onPressed: () {
                clearNameFields();
                clearNumberField();
                Navigator.of(ctx).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (ctx1) => const SplashScreen(),
                    ),
                    (route) => false);
              },
              child: const Text(
                'SignOut',
                style: TextStyle(
                    fontSize: 17, color: Colors.red, fontFamily: "SofiaPro"),
              ),
            ),
          ],
        );
      },
    );
    notifyListeners();
  }
}
