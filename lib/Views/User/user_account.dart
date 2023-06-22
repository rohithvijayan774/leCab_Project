import 'package:flutter/material.dart';
import 'package:lecab/Views/User/user_starting_page.dart';
import 'package:lecab/provider/User/bottom_nav_bar_provider.dart';
import 'package:lecab/provider/User/number_validation.dart';
import 'package:lecab/provider/User/user_details_provider.dart';
import 'package:provider/provider.dart';

class UserAccount extends StatelessWidget {
  const UserAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final userNamePro = Provider.of<UserDetailsProvider>(context);
    final userNumberPro =
        Provider.of<NumberValidationProvider>(context, listen: false);
    final userBottomNavPro = Provider.of<UserBottomNavBarProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    userNamePro.userFirstNameController.text,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Image.asset(
                    'lib/assets/profile.png',
                    scale: 5,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                indent: 20,
                endIndent: 20,
                color: Colors.grey.shade200,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "UserName",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                userNamePro.userFirstNameController.text +
                    userNamePro.userSurNameController.text,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Phone Number",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                userNumberPro.countryCodeController.text +
                    userNumberPro.numberController.text,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Email",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text(
                "userEmail",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 20,
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Call Emergency',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  userBottomNavPro.currentIndex = 0;
                  userNumberPro.clearNumberField();
                  userNamePro.clearNameFields();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (ctx1) => const UserStartingPage()),
                      (route) => false);
                },
                child: const Text(
                  'SignOut',
                  style: TextStyle(color: Colors.red, fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
