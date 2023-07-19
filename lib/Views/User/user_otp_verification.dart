import 'package:flutter/material.dart';
import 'package:lecab/Views/User/user_name.dart';
import 'package:lecab/provider/User/user_details_provider.dart';
import 'package:lecab/widget/User/user_bottom_nav_bar.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class UserOTPVerification extends StatelessWidget {
  final String verificationId;
  const UserOTPVerification({required this.verificationId, super.key});

  @override
  Widget build(BuildContext context) {
    String? otpCode;
    final userDetailsPro = Provider.of<UserDetailsProvider>(context);
    // final userDetailsProLF =
    //     Provider.of<UserDetailsProvider>(context, listen: false);
    // final defaultPinTheme = PinTheme(
    //     width: 56,
    //     height: 20,
    //     textStyle: TextStyle(
    //       fontSize: 50,
    //       color: Colors.grey,
    //     ),
    //     decoration: BoxDecoration(
    //       border: Border.all(color: Colors.black),
    //     ));
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter the OTP send to the number ${userDetailsPro.numberController.text}",
                  style: const TextStyle(fontSize: 20, fontFamily: 'SofiaPro'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Pinput(
                  length: 6,
                  showCursor: true,
                  onChanged: (value) {
                    otpCode = value;
                    // userDetailsPro.smsCode = value;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_rounded),
            ),
            ElevatedButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.grey),
                backgroundColor: MaterialStateProperty.all(Colors.black),
                minimumSize: MaterialStateProperty.all(
                  const Size(50, 40),
                ),
              ),
              onPressed: () {
                verifyOTP(context, otpCode!);
                // userDetailsProLF.verifyOTP(context);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "next",
                    style: TextStyle(
                        fontFamily: 'SofiaPro',
                        fontSize: 25,
                        color: Colors.white),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void verifyOTP(BuildContext context, String userOTP) {
    final userDetailsProLF =
        Provider.of<UserDetailsProvider>(context, listen: false);
    userDetailsProLF.verifyOTP(
        context: context,
        verificationId: verificationId,
        userOTP: userOTP,
        onSuccess: () {
          //checking user exists or not
          userDetailsProLF.checkExistingUser().then((value) async {
            if (value == true) {
              //user exists
              userDetailsProLF.getDataFromFirestore().then(
                    (value) => userDetailsProLF.saveUserdDataToSP().then(
                          (value) => userDetailsProLF.setSignIn().then(
                                (value) => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const UserBottomNavBar(),
                                    ),
                                    (route) => false),
                              ),
                        ),
                  );
            } else {
              //new User
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserName(),
                  ),
                  (route) => false);
            }
          });
        });
  }
}
