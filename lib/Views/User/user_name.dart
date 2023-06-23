import 'package:flutter/material.dart';
import 'package:lecab/Views/User/user_terms_privacy.dart';
import 'package:lecab/provider/User/number_validation.dart';
import 'package:provider/provider.dart';

class UserName extends StatelessWidget {
  const UserName({super.key});

  @override
  Widget build(BuildContext context) {
    final userDetailsPro = Provider.of<UserDetailsProvider>(context);
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
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Let us know how to address you",
                    style: TextStyle(fontSize: 15),
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
                        border: OutlineInputBorder(), hintText: 'Firstname'),
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
                        border: OutlineInputBorder(), hintText: 'Surname'),
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
              onPressed: () {
                if (userDetailsPro.userNameFormKey.currentState!.validate()) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const UserTermsAndPolicy(),
                    ),
                  );
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
}
