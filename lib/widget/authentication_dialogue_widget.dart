import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AuthenticationDialogueWidget extends StatelessWidget {
  String? message;
  AuthenticationDialogueWidget({this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 100,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const CircularProgressIndicator(
              strokeWidth: 2,
            ),
            Text(message!),
          ],
        ),
      ),
    );
  }
}
