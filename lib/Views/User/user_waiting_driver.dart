import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lecab/Views/User/user_showing_driver_info.dart';
import 'package:lecab/provider/User/user_googlemap_provider.dart';
import 'package:lecab/widget/User/Bottom%20Bar/driver_waiting_bottombar.dart';
import 'package:provider/provider.dart';

class UserWaitingDriver extends StatelessWidget {
  const UserWaitingDriver({super.key});

  @override
  Widget build(BuildContext context) {
    final googleMapProvider = Provider.of<UserGoogleMapProvider>(context);
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            GoogleMap(
              padding: EdgeInsets.only(top: 400),
              initialCameraPosition: googleMapProvider.yourLocation,
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              onMapCreated: (controller) {
                // googleMapProvider.googleMapController.complete(controller);
                googleMapProvider.newGoogleMapController = controller;
                googleMapProvider.locatePosition();

                // _newGoogleMapController = controller;
              },
              markers: {
                const Marker(
                  // icon: BitmapDescriptor.defaultMarkerWithHue(
                  //     BitmapDescriptor.hueAzure),
                  markerId: MarkerId('Your Location'),
                  position: LatLng(11.249284377235318, 75.83412108356296),
                ),
                Marker(
                  draggable: true,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueYellow),
                  markerId: const MarkerId('Driver Location'),
                  position: const LatLng(11.249753973368229, 75.83456813073674),
                )
              },
            ),
            Positioned(
              top: 10,
              right: 10,
              child: SafeArea(
                child: Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.black),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const UserDriverInfo(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const DriverWaitingBottomBar(),
    );
  }
}
