import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lecab/provider/User/user_googlemap_provider.dart';
import 'package:lecab/widget/User/home_search_button.dart';
import 'package:lecab/widget/User/Bottom%20Bar/user_home_bottom_appbar.dart';
import 'package:provider/provider.dart';

class UserHome extends StatelessWidget {
  const UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    final googleMapProvider =
        Provider.of<UserGoogleMapProvider>(context, listen: false);
      
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            GoogleMap(
              initialCameraPosition: googleMapProvider.yourLocation,
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              onMapCreated: (controller) {
                googleMapProvider.googleMapController.complete(controller);

                // _newGoogleMapController = controller;
              },
              markers: {
                const Marker(
                  // icon: BitmapDescriptor.defaultMarkerWithHue(
                  //     BitmapDescriptor.hueAzure),
                  markerId: MarkerId('Your Location'),
                  position: LatLng(11.249284377235318, 75.83412108356296),
                )
              },
            ),
            const Positioned(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  HomeSearchButton()
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const UserHomeBottomAppBar(),
    );
  }
}
