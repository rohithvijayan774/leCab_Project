import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lecab/provider/User/user_details_provider.dart';
import 'package:lecab/provider/User/user_googlemap_provider.dart';
import 'package:lecab/widget/User/Bottom%20Bar/user_select_vehicle_bottom.dart';
import 'package:provider/provider.dart';

class UserChooseVehicle extends StatelessWidget {
  const UserChooseVehicle({super.key});

  @override
  Widget build(BuildContext context) {
    final googleMapProvider = Provider.of<UserGoogleMapProvider>(context);
    final userDetailsPro =
        Provider.of<UserDetailsProvider>(context, listen: false);
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            GoogleMap(
              padding:const EdgeInsets.only(top: 300),
              initialCameraPosition: googleMapProvider.yourLocation,
              mapType: MapType.normal,
              // myLocationButtonEnabled: true,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                // googleMapProvider.googleMapController.complete(controller);
                googleMapProvider.newGoogleMapController = controller;
                googleMapProvider.locatePosition();

                // _newGoogleMapController = controller;
              },
              markers: {
                Marker(
                  // icon: BitmapDescriptor.defaultMarkerWithHue(
                  //     BitmapDescriptor.hueAzure),
                  markerId: const MarkerId('PickUp Location'),
                  position: userDetailsPro.pickUpLoc!,
                ),
                Marker(
                  // icon: BitmapDescriptor.defaultMarkerWithHue(
                  //     BitmapDescriptor.hueAzure),
                  markerId: const MarkerId('DropOff Location'),
                  position: userDetailsPro.dropOffLoc!,
                ),
              },
            ),
            Positioned(
              top: 10,
              left: 10,
              child: SafeArea(
                child: Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.black),
                  child: IconButton(
                    onPressed: () async {
                      await userDetailsPro.resetCabFare();
                      await userDetailsPro.resetDistance();
                      await userDetailsPro.resetDriver();
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
      bottomNavigationBar: const UserSelectVehicleBottomApp(),
    );
  }
}
