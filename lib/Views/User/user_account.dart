import 'package:flutter/material.dart';
import 'package:lecab/provider/User/bottom_nav_bar_provider.dart';
import 'package:lecab/provider/User/user_details_provider.dart';
import 'package:provider/provider.dart';

class UserAccount extends StatelessWidget {
  const UserAccount({super.key});

  @override
  Widget build(BuildContext context) {
    // final userNamePro = Provider.of<UserDetailsProvider>(context);
    final userDetailsPro =
        Provider.of<UserDetailsProvider>(context, listen: false);
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
                    userDetailsPro.userModel.firstName,
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  //8848463680
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 50,
                    child: Image.asset(
                      'lib/assets/user.png',
                      scale: 5,
                    ),
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
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "${userDetailsPro.userModel.firstName} ${userDetailsPro.userModel.surName}",
                style: const TextStyle(
                    fontFamily: 'SofiaPro',
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Phone Number",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                userDetailsPro.userModel.phoneNumber,
                style: const TextStyle(
                    fontFamily: 'SofiaPro',
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Email",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "userEmail",
                style: TextStyle(
                    fontFamily: 'SofiaPro',
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
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
                        fontFamily: 'Poppins',
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
                  userDetailsPro.signOut(context);
                  // userDetailsPro.clearNumberField();
                  // userDetailsPro.clearNameFields();
                  // Navigator.of(context).pushAndRemoveUntil(
                  //     MaterialPageRoute(
                  //         builder: (ctx1) => const UserStartingPage()),
                  //     (route) => false);
                },
                child: const Text(
                  'SignOut',
                  style: TextStyle(
                      fontFamily: 'SofiaPro',
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
