import 'package:flutter/material.dart';
import 'package:lecab/widget/User/payment_mode_bar.dart';

class UserPaymentMode extends StatelessWidget {
  const UserPaymentMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "Payment",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 150),
              child: Column(
                children: [
                  const Text(
                    "Pay ₹0.0",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  PaymentModeBar(
                      payIcon: 'lib/assets/cash_by_hand.png',
                      payLabel: 'Paid by Cash'),
                  const Divider(
                    indent: 40,
                    endIndent: 40,
                  ),
                  PaymentModeBar(
                      payIcon: "lib/assets/online_payment.png",
                      payLabel: 'Pay Online')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
