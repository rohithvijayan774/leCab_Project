import 'package:flutter/material.dart';
import 'package:lecab/Views/User/user_name.dart';
import 'package:lecab/provider/User/number_validation.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class UserOTPVerification extends StatelessWidget {
  const UserOTPVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<UserDetailsProvider>(context);
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
                "Enter the OTP send to the number ${pro.numberController.text}",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              const Pinput(
                length: 6,
                showCursor: true,
              )
            ],
          ),
        ),
      )),
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
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const UserName(),
                ));
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
}
