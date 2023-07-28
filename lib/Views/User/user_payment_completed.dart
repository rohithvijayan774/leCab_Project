import 'package:flutter/material.dart';
import 'package:lecab/provider/User/osm_map_provider.dart';
import 'package:lecab/provider/User/user_details_provider.dart';
import 'package:lecab/widget/User/user_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class UserPaymentCompleted extends StatelessWidget {
  const UserPaymentCompleted({super.key});

  @override
  Widget build(BuildContext context) {
    final userDetailsProLF =
        Provider.of<UserDetailsProvider>(context, listen: false);
    final osmProvider = Provider.of<OSMMAPProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () async {
                await userDetailsProLF.addDataToLists().then(
                  (value) async {
                    await userDetailsProLF.deleteRoute().then(
                      (value) async {
                        await userDetailsProLF.getDataFromFirestore().then(
                          (value) {
                            osmProvider.clearTextFields();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (ctx1) =>
                                        const UserBottomNavBar()),
                                (route) => false);
                          },
                        );
                      },
                    );
                  },
                );
              },
              icon: const Icon(Icons.close),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 250),
                child: Column(
                  children: [
                    Image.asset(
                      'lib/assets/done.png',
                      scale: 8,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Payment Completed',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
