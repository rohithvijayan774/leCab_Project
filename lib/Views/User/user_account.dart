import 'package:flutter/material.dart';
import 'package:lecab/provider/User/user_details_provider.dart';
import 'package:provider/provider.dart';

class UserAccount extends StatelessWidget {
  const UserAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final userPro = Provider.of<UserDetailsProvider>(context);
    return Scaffold(
      body: Center(
        child: Text(
            userPro.userFirstNameController.text + userPro.userSurNameController.text),
      ),
    );
  }
}
