import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PaymentModeBar extends StatelessWidget {
  String payIcon;
  String payLabel;
  Function onClick;
  PaymentModeBar({
    required this.payIcon,
    required this.payLabel,
    required this.onClick,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
          elevation: const MaterialStatePropertyAll(0),
          backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
        ),
        onPressed: () {
          onClick();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              image: AssetImage(payIcon),
              height: 50,
            ),
            Text(
              payLabel,
              style: const TextStyle(
                  fontFamily: 'SofiaPro',
                  fontSize: 23,
                  // fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
