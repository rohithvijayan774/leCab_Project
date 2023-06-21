import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class UserGoogleMapProvider extends ChangeNotifier {
  final Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();

  final CameraPosition yourLocation = const CameraPosition(
    target: LatLng(11.249284377235318, 75.83412108356296),
    zoom: 18,
  );

  LocationData? currentLocation;

  getCurrentLocation() {
    Location location = Location();

    location.getLocation().then((location) {
      currentLocation = location;
    });
    notifyListeners();
  }
}
