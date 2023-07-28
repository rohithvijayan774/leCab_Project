import 'package:flutter/material.dart';
import 'package:lecab/Views/User/user_waiting_driver.dart';
import 'package:lecab/provider/User/user_details_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class VehicleSelectionBar extends StatelessWidget {
  final String icon;
  final String vehicleType;
  final int amount;
  final int distance;

  const VehicleSelectionBar({
    required this.icon,
    required this.vehicleType,
    required this.amount,
    required this.distance,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userDetailsPro =
        Provider.of<UserDetailsProvider>(context, listen: false);
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
        onPressed: () async {
          userDetailsPro.updateSelectedVehicle(vehicleType,amount).then(
                (value) => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UserWaitingDriver(),
                  ),
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
