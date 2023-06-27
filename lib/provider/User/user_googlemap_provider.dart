import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';


class UserGoogleMapProvider extends ChangeNotifier {
  final Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();


  Position? currentPosition;
  var geoLocator = Geolocator();
  GoogleMapController? newGoogleMapController;


  locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    currentPosition = position;

    ;
    LatLng latLngPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        CameraPosition(target: latLngPosition, zoom: 20);

    newGoogleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    log("${latLngPosition}");
    notifyListeners();
  }

  CameraPosition yourLocation = CameraPosition(
    target: LatLng(0.0, 0.0),
    zoom: 18,
  );
}
