import 'package:flutter/material.dart';

class DriverWaitingBottomBar extends StatelessWidget {
  const DriverWaitingBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      decoration: const BoxDecoration(
          // color: Colors.grey,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Please wait, your driver is on the way...',
              style: TextStyle(
                  fontFamily: 'SofiaPro',
                  fontWeight: FontWeight.w600,
                  fontSize: 25),
            ),
            const SizedBox(
              height: 20,
            ),
            const LinearProgressIndicator(
              minHeight: 2,
              color: Colors.black,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
              style: ButtonStyle(
                // shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(15))),
                overlayColor: MaterialStateProperty.all(Colors.grey),
                backgroundColor: MaterialStateProperty.all(Colors.black),
                minimumSize: MaterialStateProperty.all(
                  const Size(200, 50),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              label: const Text(
                "Cancel ride",
                style: TextStyle(
                  fontFamily: 'SofiaPro',
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
