// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthProvider extends ChangeNotifier {
//   bool _isSignedIn = false;
//   bool get isSignedIn => _isSignedIn;

//   AuthProvider() {
//     checkSignedIn();
  
//   }

//   void checkSignedIn() async {
//     final SharedPreferences sharedPreferences =
//         await SharedPreferences.getInstance();
//     _isSignedIn = sharedPreferences.getBool('is_signedIn') ?? false;
//     notifyListeners();
//   }

//   Future setSignIn() async {
//     final SharedPreferences sharedPreferences =
//         await SharedPreferences.getInstance();
//     sharedPreferences.setBool('is_signedIn', true);
//     _isSignedIn = true;

//     notifyListeners();
//   }
// }
