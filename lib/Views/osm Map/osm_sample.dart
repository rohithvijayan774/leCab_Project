import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:lecab/Views/osm%20Map/osm_search.dart';
import 'package:lecab/provider/User/osm_map_provider.dart';
import 'package:provider/provider.dart';

class OSMSample extends StatelessWidget {
  const OSMSample({super.key});

  @override
  Widget build(BuildContext context) {
    final osmProvider = Provider.of<OSMMAPProvider>(context);
    final osmProviderLF = Provider.of<OSMMAPProvider>(context, listen: false);
    osmProviderLF.tapMap();

    return Scaffold(
      body: OSMFlutter(
        androidHotReloadSupport: true,
        controller: osmProvider.mapController,
        userTrackingOption: const UserTrackingOption(
          enableTracking: true,
          unFollowUser: true,
        ),
        initZoom: 17,
        minZoomLevel: 8,
        maxZoomLevel: 19,
        stepZoom: 1.0,
        userLocationMarker: UserLocationMaker(
          personMarker: const MarkerIcon(
            icon: Icon(
              Icons.location_pin,
              color: Colors.red,
              size: 100,
            ),
          ),
          directionArrowMarker: const MarkerIcon(
            icon: Icon(
              Icons.double_arrow,
              size: 48,
              color: Colors.black,
            ),
          ),
        ),
        roadConfiguration: const RoadOption(
          roadColor: Colors.yellowAccent,
        ),
        markerOption: MarkerOption(
            defaultMarker: const MarkerIcon(
          icon: Icon(
            Icons.person_pin_circle,
            color: Colors.blue,
            size: 56,
          ),
        )),
        onMapIsReady: (isReady) async {
          if (isReady) {
            await Future.delayed(const Duration(seconds: 1), () async {
              await osmProvider.mapController.currentLocation();
            });
          }
        },
        onGeoPointClicked: (geoPoint) {
          var key = '${geoPoint.latitude},${geoPoint.longitude}';
          log(geoPoint.toString());
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Position ${osmProvider.markerMap['']}'),
                          Divider(),
                          Text(key)
                        ],
                      )),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.close),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OSMSearch(),
        ));
      }),
    );
  }
}
