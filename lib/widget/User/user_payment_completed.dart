import 'package:flutter/material.dart';

class UserPaymentCompleted extends StatelessWidget {
  const UserPaymentCompleted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
