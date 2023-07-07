import 'package:flutter/material.dart';
import 'package:lecab/Views/User/user_terms_privacy.dart';

import 'package:lecab/provider/User/user_details_provider.dart';
import 'package:lecab/provider/splash_screen_provider.dart';
import 'package:provider/provider.dart';

class UserName extends StatelessWidget {
  const UserName({super.key});

  @override
  Widget build(BuildContext context) {
    final userDetailsPro = Provider.of<UserDetailsProvider>(context);
    // final splashProvider =
    //     Provider.of<SplashScreenProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: userDetailsPro.userNameFormKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 50,
                left: 10,
                right: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "What's your name?",
                    style: TextStyle(fontSize: 25, fontFamily: 'SofiaPro'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Let us know how to address you",
                    style: TextStyle(fontSize: 15, fontFamily: "SofiaPro"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '* This field is Required';
                      } else {
                        return null;
                      }
                    },
                    textCapitalization: TextCapitalization.words,
                    controller: userDetailsPro.userFirstNameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Firstname',
                        hintStyle: TextStyle(fontFamily: 'SofiaPro')),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '* This field is Required';
                      } else {
                        return null;
                      }
                    },
                    textCapitalization: TextCapitalization.words,
                    controller: userDetailsPro.userSurNameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Surname',
                        hintStyle: TextStyle(fontFamily: 'SofiaPro')),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.grey),
                backgroundColor: MaterialStateProperty.all(Colors.black),
                minimumSize: MaterialStateProperty.all(
                  const Size(50, 40),
                ),
              ),
              onPressed: () async {
                if (userDetailsPro.userNameFormKey.currentState!.validate()) {
                  userDetailsPro.storeData(context, () {
                    userDetailsPro.saveUserdDataToSP().then((value) =>
                        userDetailsPro
                            .setSignIn()
                            .then((value) => Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const UserTermsAndPolicy(),
                                ),
                                (route) => false)));
                  });
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => const UserTermsAndPolicy(),
                  //   ),
                  // );
                }
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

  //Store user data to database
}
