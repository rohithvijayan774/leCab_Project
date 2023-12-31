import 'package:flutter/material.dart';
import 'package:lecab/provider/User/bottom_nav_bar_provider.dart';
import 'package:provider/provider.dart';

class UserBottomNavBar extends StatelessWidget {
  const UserBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<UserBottomNavBarProvider>(context);
    return Scaffold(
      body: pro.pages[pro.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        currentIndex: pro.currentIndex,
        onTap: (index) {
          // pro.currentIndex = index;
          pro.updateIndex(index);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.history,
              ),
              label: 'Activity'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'Account'),
        ],
      ),
    );
  }
}
