import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lecab/Views/User/user_payment_mode.dart';
import 'package:lecab/provider/User/bottom_nav_bar_provider.dart';
import 'package:lecab/provider/User/user_details_provider.dart';
import 'package:lecab/widget/User/user_image_viewer.dart';
import 'package:provider/provider.dart';

class UserAccount extends StatelessWidget {
  const UserAccount({super.key});

  @override
  Widget build(BuildContext context) {
    // final userNamePro = Provider.of<UserDetailsProvider>(context);
    final userDetailsPro =
        Provider.of<UserDetailsProvider>(context, listen: false);
    final userBottomNavPro = Provider.of<UserBottomNavBarProvider>(context);
    log('Have pic? ${userDetailsPro.userModel.profilePicture}');
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
                  Consumer<UserDetailsProvider>(
                    builder: (context, value, _) {
                      return Stack(
                        children: [
                          InkWell(
                            onLongPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImageViewer(
                                      image: value.userModel.profilePicture),
                                ),
                              );
                            },
                            child: value.userModel.profilePicture == null
                                ? const CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 50,
                                    backgroundImage: AssetImage(
                                      'lib/assets/user.png',
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 50,
                                    // backgroundColor: Colors.black,
                                    backgroundImage: NetworkImage(
                                      value.userModel.profilePicture!,
                                      scale: 5,
                                    ),
                                  ),
                          ),
                          Positioned(
                            bottom: -10,
                            right: 50,
                            child: IconButton(
                              onPressed: () async {
                                await value.selectImage(context);
                                await value.uploadProfilePic(
                                  value.image!,
                                  () {
                                    value.saveUserdDataToSP().then(
                                      (value) {
                                        userDetailsPro.setSignIn();
                                      },
                                    );
                                  },
                                );
                                log('Uplaoded : ${value.userModel.profilePicture!}');
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
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
                  userDetailsPro.signOut(context);
                  userBottomNavPro.currentIndex = 0;
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UserPaymentMode(),
            ),
          );
        },
      ),
    );
  }
}
