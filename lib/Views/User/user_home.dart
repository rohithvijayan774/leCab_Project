import 'package:flutter/material.dart';
import 'package:lecab/Views/User/user_search.dart';
import 'package:lecab/widget/User/home_search_button.dart';
import 'package:lecab/widget/User/user_home_bottom_appbar.dart';

class UserHome extends StatelessWidget {
  const UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              color: Colors.amber,
              height: double.infinity,
              child: Image.asset(
                'lib/assets/home_map.png',
                height: 200,
              ),
            ),
            Positioned(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                SizedBox(
                  height: 60,
                ),
                HomeSearchButton()
              ],
            ))
          ],
        ),
      ),
      bottomNavigationBar: const UserHomeBottomAppBar(),
    );
  }
}
