import 'package:flutter/material.dart';
import 'package:lecab/Views/User/user_otp_verification.dart';
import 'package:lecab/provider/User/number_validation.dart';
import 'package:provider/provider.dart';

class UserNumberValidation extends StatelessWidget {
  const UserNumberValidation({super.key});

  @override
  Widget build(BuildContext context) {
    final userDetailsPro = Provider.of<UserDetailsProvider>(context);
    final userDetailsProLF =
        Provider.of<UserDetailsProvider>(context, listen: false);
    userDetailsPro.countryCodeController.text = "+91";
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: userDetailsPro.numberFormKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 250, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Enter your mobile number",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 40,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '* This field is required';
                              } else {
                                return null;
                              }
                            },
                            controller: userDetailsPro.countryCodeController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const VerticalDivider(
                          indent: 10,
                          endIndent: 10,
                        ),
                        Expanded(
                          child: SizedBox(
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '* This field is required';
                                } else {
                                  return null;
                                }
                              },
                              controller: userDetailsPro.numberController,
                              // maxLength: 10,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Center(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(Colors.grey),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                          minimumSize: MaterialStateProperty.all(
                            const Size(200, 50),
                          ),
                        ),
                        onPressed: () async {
                          if (userDetailsPro.numberFormKey.currentState!
                              .validate()) {
                            await userDetailsProLF.sendOTP(context);
                          }
                        },
                        child: const Text(
                          "Continue",
                          style: TextStyle(
                              fontFamily: 'SofiaPro',
                              fontSize: 22,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        elevation: 0,
        child: Text(
          "By proceeding, you consent to get calls, WhatsApp or SMS messages, including by automated means, from leCab and its affiliates to the number provided.",
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ),
    );
  }
}
