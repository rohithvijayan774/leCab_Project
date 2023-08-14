import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
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
            StreamBuilder<QuerySnapshot>(
                stream: userDetailsPro.firebaseFirestore
                    .collection('drivers')
                    .snapshots(),
                builder: (context, snapshot) {
                  userDetailsPro.getDataFromFirestore().then((value) {
                    userDetailsPro.fetchDriver(context, snapshot.data!);
                  });

                  log('driver Null : ${userDetailsPro.driver == null}');
                  if (userDetailsPro.driver != null) {
                    log('Driver Not null');
                    if (snapshot.hasData) {
                      log('Entered snapshot.data');
                      return GoogleMap(
                          padding: const EdgeInsets.only(top: 400),
                          initialCameraPosition: googleMapProvider.yourLocation,
                          mapType: MapType.normal,
                          myLocationButtonEnabled: true,
                          myLocationEnabled: true,
                          onMapCreated: (controller) {
                            // googleMapProvider.googleMapController.complete(controller);
                            googleMapProvider.newGoogleMapController =
                                controller;
                            googleMapProvider.locatePosition();
                          },
                          markers: userDetailsPro.userModel.selectedDriver !=
                                  null
                              ? {
                                  Marker(
                                    icon: BitmapDescriptor.defaultMarkerWithHue(
                                        BitmapDescriptor.hueAzure),
                                    position: LatLng(
                                        userDetailsPro
                                            .driver!.driverLocation.latitude,
                                        userDetailsPro
                                            .driver!.driverLocation.longitude),
                                    markerId: const MarkerId(
                                      'DriverLocation',
                                    ),
                                  )
                                }
                              : {});
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return const CircularProgressIndicator();
                    }
                  } else {
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
                    );
                  }
                }),
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
