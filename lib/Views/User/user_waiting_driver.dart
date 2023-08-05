import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lecab/Views/User/user_showing_driver_info.dart';
import 'package:lecab/provider/User/user_details_provider.dart';
import 'package:lecab/provider/User/user_googlemap_provider.dart';
import 'package:lecab/widget/User/Bottom%20Bar/driver_waiting_bottombar.dart';
import 'package:provider/provider.dart';

class UserWaitingDriver extends StatelessWidget {
  const UserWaitingDriver({super.key});

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
            Consumer<UserDetailsProvider>(builder: (ctx, value, _) {
              value.getDataFromFirestore().then((value) {
                userDetailsPro.fetchDriver();
              });
              print('${value.driver == null}');
             
              return GoogleMap(
                  padding: const EdgeInsets.only(top: 400),
                  initialCameraPosition: googleMapProvider.yourLocation,
                  mapType: MapType.normal,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  onMapCreated: (controller) {
                    // googleMapProvider.googleMapController.complete(controller);
                    googleMapProvider.newGoogleMapController = controller;
                    googleMapProvider.locatePosition();
                  },
                  markers: value.driver != null
                      ? {
                          Marker(
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueAzure),
                            position: LatLng(
                                value.driver!.driverLocation.latitude,
                                value.driver!.driverLocation.longitude),
                            markerId: const MarkerId(
                              'DriverLocation',
                            ),
                          )
                        }
                      : {});
            }),
            Consumer<UserDetailsProvider>(builder: (context, value, _) {
              return Positioned(
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
              );
            })
          ],
        ),
      ),
      bottomNavigationBar: const DriverWaitingBottomBar(),
    );
  }
}
