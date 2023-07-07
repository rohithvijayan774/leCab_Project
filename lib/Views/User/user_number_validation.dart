import 'package:flutter/material.dart';
import 'package:lecab/provider/User/user_details_provider.dart';
import 'package:provider/provider.dart';

class UserNumberValidation extends StatelessWidget {
  const UserNumberValidation({super.key});

  @override
  Widget build(BuildContext context) {
    final userDetailsPro = Provider.of<UserDetailsProvider>(context);
    final userDetailsProLF =
        Provider.of<UserDetailsProvider>(context, listen: false);
    // userDetailsPro.countryCodeController.text = "+91";
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
                      fontFamily: 'SofiaPro',
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: userDetailsPro.numberController,
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(
                          color: Colors.grey, fontFamily: 'SofiaPro'),
                      hintText: 'Enter your phone number',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black26),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black26),
                      ),
                      prefixIcon: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            userDetailsPro.showCountries(context);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${userDetailsPro.selectedCountry.flagEmoji} + ${userDetailsPro.selectedCountry.phoneCode}",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                  const SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      userDetailsPro.otpError == null
                          ? const Text('')
                          : Consumer<UserDetailsProvider>(
                              builder: (context, value, _) {
                              return Text(
                                value.otpError!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.red, fontFamily: 'SofiaPro'),
                              );
                            }),
                    ],
                  )
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
