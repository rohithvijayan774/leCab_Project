import 'package:flutter/material.dart';
import 'package:lecab/widget/User/user_home_bottom_appbar.dart';

class UserChooseVehicle extends StatelessWidget {
  const UserChooseVehicle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              color: Colors.white,
              height: double.infinity,
              child: Image.asset(
                'lib/assets/home_map.png',
                height: 200,
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.black),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const UserHomeBottomAppBar(),
    );
  }
}
