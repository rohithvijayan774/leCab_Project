import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:lecab/Views/User/user_choose_vehicle.dart';
import 'package:lecab/provider/User/osm_map_provider.dart';
import 'package:provider/provider.dart';

class UserSearch extends StatelessWidget {
  const UserSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final osmProviderLF = Provider.of<OSMMAPProvider>(context, listen: false);
    final osmProvider = Provider.of<OSMMAPProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Where to ?',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    const Icon(Icons.arrow_downward_rounded),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          TextFormField(
                            focusNode: osmProvider.firstFocusNode,
                            controller: osmProvider.pickUpTextController,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Your current location'),
                            onChanged: (value) async {
                              osmProvider.controller.isLoading.value = true;
                              var data = await addressSuggestion(
                                  osmProvider.pickUpTextController.text);
                              if (data.isNotEmpty) {
                                osmProvider.controller.listSource.value = data;
                              }
                              osmProvider.controller.isLoading.value = false;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            focusNode: osmProvider.secondFocusNode,
                            controller: osmProvider.dropOffTextController,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(), hintText: 'To?'),
                            onChanged: (value) async {
                              osmProvider.controller.isLoading.value = true;
                              var data = await addressSuggestion(
                                  osmProvider.dropOffTextController.text);
                              if (data.isNotEmpty) {
                                osmProvider.controller.listSource.value = data;
                              }
                              osmProvider.controller.isLoading.value = false;
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                indent: 20,
                endIndent: 20,
              ),
              Obx(
                () => Expanded(
                  child: osmProvider.controller.listSource.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: osmProvider.controller.listSource.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () async {
                                //Pickup TextField
                                if (osmProvider.firstFocusNode.hasFocus) {
                                  osmProvider.coordinates = await osmProviderLF
                                      .getCoordinatesFromAddress(osmProvider
                                          .pickUpTextController.text);
                                  if (osmProvider.coordinates != null) {
                                    osmProvider.pickupLatitude =
                                        osmProvider.coordinates!.latitude;
                                    osmProvider.pickupLongitude =
                                        osmProvider.coordinates!.longitude;
                                    log('Pickup Coordinates : ${osmProvider.pickupLatitude}, ${osmProvider.pickupLongitude}');
                                  }
                                  osmProvider.pickUpTextController.text =
                                      osmProvider.controller.listSource[index]
                                          .address!.name
                                          .toString();
                                  //DropOff TextField
                                } else if (osmProvider
                                    .secondFocusNode.hasFocus) {
                                  osmProvider.coordinates = await osmProviderLF
                                      .getCoordinatesFromAddress(osmProvider
                                          .dropOffTextController.text);
                                  if (osmProvider.coordinates != null) {
                                    osmProvider.dropOffLatitude =
                                        osmProvider.coordinates!.latitude;
                                    osmProvider.dropOffLongitude =
                                        osmProvider.coordinates!.longitude;
                                    log('DropOff Coordinates : ${osmProvider.dropOffLatitude}, ${osmProvider.dropOffLongitude}');
                                  }
                                  osmProvider.dropOffTextController.text =
                                      osmProvider.controller.listSource[index]
                                          .address!.name
                                          .toString();
                                }
                              },
                              leading: const Icon(Icons.location_pin),
                              title: Text(
                                osmProvider
                                    .controller.listSource[index].address!.name
                                    .toString(),
                                style: const TextStyle(
                                    fontFamily: 'SofiaPro',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                osmProvider.controller.listSource[index].address
                                    .toString(),
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
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: ElevatedButton(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.grey),
            backgroundColor: MaterialStateProperty.all(Colors.black),
            minimumSize: MaterialStateProperty.all(
              const Size(50, 40),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const UserChooseVehicle(),
                ),
                (route) => false);
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "next",
                style: TextStyle(
                    fontFamily: 'SofiaPro', fontSize: 25, color: Colors.white),
              ),
              Icon(
                Icons.chevron_right_rounded,
                size: 30,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
