import 'package:flutter/material.dart';
import 'package:lecab/Views/User/user_number_validation.dart';
import 'package:permission_handler/permission_handler.dart';

class UserStartingPage extends StatelessWidget {
  const UserStartingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: 30,
            ),
            child: Center(
              child: Column(
                children: [
                  const Text(
                    "Hire\nCab\nfor your Trip",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 100,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: Image.asset("lib/assets/taxi_front_page.png"),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
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
                        PermissionStatus locationPermission =
                            await Permission.location.request();

                        if (locationPermission == PermissionStatus.granted) {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const UserNumberValidation(),
                          ));
                        }

                       
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Get Started",
                            style: TextStyle(
                              fontFamily: 'SofiaPro',
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: 30,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
