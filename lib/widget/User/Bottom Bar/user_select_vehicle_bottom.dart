import 'package:flutter/material.dart';
import 'package:lecab/provider/User/user_details_provider.dart';
import 'package:lecab/widget/User/vehicle_selection_bar.dart';
import 'package:provider/provider.dart';

class UserSelectVehicleBottomApp extends StatelessWidget {
  const UserSelectVehicleBottomApp({super.key});

  @override
  Widget build(BuildContext context) {
    final userDetailsPro = Provider.of<UserDetailsProvider>(context);
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
            VehicleSelectionBar(
                icon: 'lib/assets/rickshaw3D.png',
                vehicleType: 'Auto',
                amount: 0,
                distance: userDetailsPro.formattedDistance!),
            const SizedBox(
              height: 20,
            ),
            VehicleSelectionBar(
              icon: 'lib/assets/suv3D.png',
              vehicleType: 'SUV',
              amount: 0,
              distance: userDetailsPro.formattedDistance!,
            ),
            const SizedBox(
              height: 20,
            ),
            VehicleSelectionBar(
              icon: 'lib/assets/car.png',
              vehicleType: 'Car',
              amount: 0,
              distance: userDetailsPro.formattedDistance!,
            ),
          ],
        ),
      ),
    );
  }
}
