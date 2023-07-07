import 'package:flutter/material.dart';
import 'package:lecab/provider/User/user_details_provider.dart';
import 'package:lecab/provider/splash_screen_provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userDetailsPro =
        Provider.of<UserDetailsProvider>(context, listen: false);
    userDetailsPro.gotoNextPage(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "leCab.",
              style: TextStyle(
                  fontSize: 80,
                  fontFamily: "Fabada",
                  fontWeight: FontWeight.bold),
            ),
            LoadingAnimationWidget.newtonCradle(color: Colors.black, size: 100),
          ],
        ),
      ),
    );
  }
}
