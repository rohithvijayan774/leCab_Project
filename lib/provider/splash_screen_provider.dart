// import 'package:flutter/material.dart';
// import 'package:lecab/Views/User/user_starting_page.dart';
// import 'package:lecab/widget/User/user_bottom_nav_bar.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SplashScreenProvider extends ChangeNotifier {
//   bool _isSignedIn = false;
//   bool get isSignedIn => _isSignedIn;

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

//   gotoNextPage(context) async {
//     await Future.delayed(const Duration(seconds: 3));
//     if (isSignedIn == true) {
//       await 
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const UserBottomNavBar(),
//           ));
//     } else {
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const UserStartingPage(),
//           ));
//     }

//     notifyListeners();
//   }
// }
