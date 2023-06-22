import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
// import 'package:location/location.dart';

class UserGoogleMapProvider extends ChangeNotifier {
  final Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();

  LocationData? currentLocation;

  // getCurrentLocation() async {
  //   Location location = Location();

  //   await location.getLocation().then((location) {
  //     currentLocation = location;
  //   });
  //   notifyListeners();
  // }

  // Future<Position> getCurrentLocationGeo() async {
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('Location Service are disabled');
  //   }

  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error("Location Permissions are denied");
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error('Location Permanently denied');
  //   }

  //   return await Geolocator.getCurrentPosition();
  // }

  Location location = Location();
  bool? serviceEnabled;
  PermissionStatus? permissionGranted;
  LocationData? locationData;
  bool isGetLocation = false;

  getCurrentLocation() async {
    serviceEnabled = await location.serviceEnabled();
    if (serviceEnabled == false) {
      serviceEnabled = await location.requestService();
      if (serviceEnabled == false) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    locationData = await location.getLocation();

    isGetLocation = true;
    log("${locationData!.latitude} , ${locationData!.longitude}");
    notifyListeners();
  }

  final CameraPosition yourLocation = const CameraPosition(
    target: LatLng(11.249284377235318, 75.83412108356296),
    zoom: 18,
  );
}
