import 'package:flutter/material.dart';

class UserDetailsProvider extends ChangeNotifier {
  TextEditingController userFirstNameController = TextEditingController();
  TextEditingController userSurNameController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  final userNameFormKey = GlobalKey<FormState>();

  clearNameFields() {
    userFirstNameController.clear();
    userSurNameController.clear();
    notifyListeners();
  }
}
