import 'package:flutter/material.dart';
import 'package:lecab/Views/User/user_waiting_driver.dart';

// ignore: must_be_immutable
class VehicleSelectionBar extends StatelessWidget {
  late String icon;
  late String vehicleType;
  late int amount;
  late int distance;
  VehicleSelectionBar({
    required this.icon,
    required this.vehicleType,
    required this.amount,
    required this.distance,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
          elevation: const MaterialStatePropertyAll(0),
          backgroundColor: MaterialStatePropertyAll(Colors.grey.shade200),
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const UserWaitingDriver(),
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(
              image: AssetImage(icon),
              height: 50,
            ),
            Text(
              vehicleType,
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 23,
                  // fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '₹$amount',
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 23,
                      // fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  "$distance km",
                  style: const TextStyle(
                      fontFamily: 'SofiaPro',
                      fontSize: 15,

                      // fontWeight: FontWeight.bold,
                      color: Colors.black38),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
