import 'package:flutter/material.dart';
import 'package:lecab/Views/User/user_journey.dart';

// ignore: must_be_immutable
class UserDriverInfoBottomApp extends StatelessWidget {
  String driverPic;
  String driverName;
  String vehicleNumber;
  UserDriverInfoBottomApp(
      {required this.driverPic,
      required this.driverName,
      required this.vehicleNumber,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      decoration: const BoxDecoration(
          // color: Colors.grey,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Driver Info",
              style: TextStyle(fontFamily: 'Poppins', fontSize: 22),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Name',
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 20),
                    ),
                    Text(
                      driverName,
                      style:
                          const TextStyle(fontFamily: 'SofiaPro', fontSize: 23),
                    ),
                  ],
                ),
                Image.asset(
                  driverPic,
                  scale: 6,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Vehicle Number",
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 20),
                ),
                Text(
                  vehicleNumber,
                  style: const TextStyle(fontFamily: 'SofiaPro', fontSize: 23),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => UserJourney(),
                        ),
                      );
                    },
                    child: const Text(
                      "Accept",
                      style: TextStyle(
                          fontFamily: 'SofiaPro',
                          fontSize: 22,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
