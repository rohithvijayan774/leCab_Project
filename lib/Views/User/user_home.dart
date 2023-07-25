import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lecab/Views/osm%20Map/osm_sample.dart';
import 'package:lecab/provider/User/user_details_provider.dart';
import 'package:lecab/provider/User/user_googlemap_provider.dart';
import 'package:lecab/widget/User/home_search_button.dart';
import 'package:lecab/widget/User/Bottom%20Bar/user_home_bottom_appbar.dart';
import 'package:provider/provider.dart';

class UserHome extends StatelessWidget {
  const UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    final googleMapProvider = Provider.of<UserGoogleMapProvider>(context);
    final userDetailsProLF =
        Provider.of<UserDetailsProvider>(context, listen: false);
    userDetailsProLF.storeUserCurrentLocation();

    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            GoogleMap(
              padding: const EdgeInsets.only(top: 300),

              initialCameraPosition: googleMapProvider.yourLocation,
              mapType: MapType.normal,
              // myLocationButtonEnabled: true,
              compassEnabled: true,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                // googleMapProvider.googleMapController.complete(controller);
                googleMapProvider.newGoogleMapController = controller;
                googleMapProvider.locatePosition();
              },
              // markers: {
              //   Marker(
              //     // icon: BitmapDescriptor.defaultMarkerWithHue(
              //     //     BitmapDescriptor.hueAzure),
              //     markerId:const MarkerId('Destinatin Location'),
              //     position: destinationLocation,
              //   ),
              // },
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
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => const OSMSample(),
      //   ));
      // }),
    );
  }
}
