import 'package:flutter/material.dart';
import 'package:lecab/widget/User/user_home_bottom_appbar.dart';

class UserHome extends StatelessWidget {
  const UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
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
              children: [
                SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white60,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        hintText: 'Search'),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
      // body: ListView.builder(
      //   itemBuilder: (context, index) {
      //     return ListTile(
      //       title: Text("Item ${index + 1}"),
      //     );
      //   },
      //   itemCount: 100,
      // ),
      bottomNavigationBar: const UserHomeBottomAppBar(),
    );
  }
}
