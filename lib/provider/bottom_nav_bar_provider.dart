import 'package:flutter/material.dart';
import 'package:lecab/Views/User/user_account.dart';
import 'package:lecab/Views/User/user_activity.dart';
import 'package:lecab/Views/User/user_home.dart';

class UserBottomNavBarProvider extends ChangeNotifier {
  int currentIndex = 0;

  List<Widget> pages = [
    UserHome(),
    UserActivity(),
    UserAccount(),
  ];

  updateIndex(int newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }
}

// class BottomNavBarDTO {
//   Widget? widget;
//   String? label;
//   IconData? iconData;

//   BottomNavBarDTO({
//     this.widget,
//     this.label,
//     this.iconData,
//   });
// }
