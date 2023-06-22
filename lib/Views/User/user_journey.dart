import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lecab/Views/User/user_payment_mode.dart';
import 'package:lecab/provider/User/user_googlemap_provider.dart';
import 'package:lecab/widget/User/Bottom%20Bar/user_journey_bottmapp.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class UserJourney extends StatelessWidget {
  DateTime? dateTime;
  UserJourney({this.dateTime, super.key});

  @override
  Widget build(BuildContext context) {
    dateTime = DateTime.now();
    Duration durationToAdd =const Duration(minutes: 20);
    DateTime timeTaking = dateTime!.add(durationToAdd);
    String time = DateFormat('h:mm a').format(timeTaking).toLowerCase();

    final googleMapProvider = Provider.of<UserGoogleMapProvider>(context);
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
                          builder: (context) => const UserPaymentMode(),
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
      bottomNavigationBar: UserJourneyBottomBar(
          estReachTime: time,
          distanceToDestn: 8.5,
          timeToReach: 20,
          destnName: 'Railwaystation 4th Platform Road'),
    );
  }
}
