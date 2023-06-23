import 'package:flutter/material.dart';
import 'package:lecab/widget/User/user_bottom_nav_bar.dart';

class UserPaymentCompleted extends StatelessWidget {
  const UserPaymentCompleted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (ctx1) => const UserBottomNavBar()),
                    (route) => false);
              },
              icon: const Icon(Icons.close),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 250),
                child: Column(
                  children: [
                    Image.asset(
                      'lib/assets/done.png',
                      scale: 8,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Payment Completed',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
