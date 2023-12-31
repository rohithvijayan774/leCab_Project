import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lecab/provider/User/user_details_provider.dart';
import 'package:lecab/provider/User/user_googlemap_provider.dart';
import 'package:lecab/widget/User/Bottom%20Bar/user_driver_info_bottomapp.dart';
import 'package:provider/provider.dart';

class UserDriverInfo extends StatelessWidget {
  const UserDriverInfo({super.key});

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
              padding: EdgeInsets.only(top: 300),
              initialCameraPosition: googleMapProvider.yourLocation,
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              onMapCreated: (controller) {
                // googleMapProvider.googleMapController.complete(controller);
                googleMapProvider.newGoogleMapController = controller;
                googleMapProvider.locatePosition();
              },
              markers: {
                const Marker(
                  // icon: BitmapDescriptor.defaultMarkerWithHue(
                  //     BitmapDescriptor.hueAzure),
                  markerId: MarkerId('Your Location'),
                  position: LatLng(11.249284377235318, 75.83412108356296),
                ),
                Marker(
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueYellow),
                  markerId: const MarkerId('Driver Location'),
                  position: const LatLng(11.249294735940275, 75.83407884348500),
                ),
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: UserDriverInfoBottomApp(
          driverPic: 'lib/assets/profile.png',
          driverName: userDetailsPro.driver!.driverFirstName,
          vehicleNumber: 'KL 11 AQ 9221'),
    );
  }
}
