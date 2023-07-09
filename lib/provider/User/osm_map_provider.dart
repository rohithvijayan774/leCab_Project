import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Views/osm Map/osm_state.dart';

class OSMMAPProvider extends ChangeNotifier {
  var controller = Get.put(MainStateController());
  var pickUpTextController = TextEditingController();
  var dropOffTextController = TextEditingController();
  FocusNode firstFocusNode = FocusNode();
  FocusNode secondFocusNode = FocusNode();
  LatLng? coordinates;
  LatLng? pickUpCoordinates;
  LatLng? dropOffCoordinates;
  // double? dropOffLatitude;
  // double? dropOffLongitude;
  var markerMap = <String, String>{};
  var position;

  MapController mapController = MapController(
    initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
    areaLimit: BoundingBox(
      east: 10.4922941,
      north: 47.8084648,
      south: 45.817995,
      west: 5.9559113,
    ),
  );

  tapMap() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mapController.listenerMapSingleTapping.addListener(() async {
        position = mapController.listenerMapSingleTapping.value;
        if (position != null) {
          await mapController.addMarker(position,
              markerIcon: const MarkerIcon(
                icon: Icon(
                  Icons.location_on_outlined,
                  color: Colors.blue,
                  size: 100,
                ),
              ));
        }
        // log(position.toString());
        var key = '${position!.latitude}_${position.longitude}';
        markerMap[key] = markerMap.length.toString();
      });
    });
  }

  Future<LatLng?> getCoordinatesFromAddress(String address) async {
    log('Entered to function');
    try {
      List<Location> location = await locationFromAddress(address);
      if (location.isNotEmpty) {
        Location firstLocation = location.first;
        return LatLng(firstLocation.latitude, firstLocation.longitude);
      }
    } catch (e) {
      log('$e');
    }
    return null;
  }
}
