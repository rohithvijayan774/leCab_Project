import 'package:flutter/material.dart';
import 'package:lecab/Views/User/user_starting_page.dart';

class SplashScreenProvider extends ChangeNotifier {
  gotoNextPage(context) async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const UserStartingPage(),
      ),
    );

    notifyListeners();
  }
}
