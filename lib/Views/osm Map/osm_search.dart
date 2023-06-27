import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lecab/Views/osm%20Map/osm_state.dart';

class OSMSearch extends StatelessWidget {
  const OSMSearch({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(MainStateController());
    var textController = TextEditingController();
    // final OSMProvider = Provider.of<OSMMAPProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: textController,
                      onChanged: (value) async {
                        controller.isLoading.value = true;
                        var data = await addressSuggestion(textController.text);
                        if (data.isNotEmpty) {
                          controller.listSource.value = data;
                        }
                        controller.isLoading.value = false;
                      },
                    ),
                  ),
                  IconButton(
                      onPressed: () async {}, icon: const Icon(Icons.search))
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                  indent: 10,
                  endIndent: 10,
                ),
              ),
              Obx(
                () => Expanded(
                  child: controller.listSource.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: controller.listSource.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () async {
                                LatLng? coordinates =
                                    await getCoordinatesFromAddress(
                                        textController.text);
                                if (coordinates != null) {
                                  double latitude = coordinates.latitude;
                                  double longitude = coordinates.longitude;
                                  log('Coordinates : ${latitude} , ${longitude}');
                                } else {
                                  Text('Address not found');
                                }
                              },
                              leading: const Icon(Icons.location_pin),
                              title: Text(
                                controller.listSource[index].address!.name
                                    .toString(),
                                style: const TextStyle(
                                    fontFamily: 'SofiaPro',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                controller.listSource[index].address.toString(),
                                style: const TextStyle(
                                    fontFamily: 'SofiaPro',
                                    color: Colors.black45,
                                    fontSize: 15),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            );
                          },
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
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
      log('${e}');
    }
    return null;
  }
}
