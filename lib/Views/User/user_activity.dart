import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lecab/provider/User/user_googlemap_provider.dart';
import 'package:provider/provider.dart';

class UserActivity extends StatelessWidget {
  const UserActivity({super.key});

  @override
  Widget build(BuildContext context) {
    final googleMapProvider =
        Provider.of<UserGoogleMapProvider>(context, listen: false);
    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
          initialCameraPosition: googleMapProvider.yourLocation,
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          onMapCreated: (controller) {
            googleMapProvider.googleMapController.complete(controller);
           
            // _newGoogleMapController = controller;
          },
        ),
      ],
    ));
  }
}
