import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:lecab/Views/User/user_choose_vehicle.dart';
import 'package:lecab/provider/User/osm_map_provider.dart';
import 'package:lecab/provider/User/user_details_provider.dart';
import 'package:provider/provider.dart';

class UserSearch extends StatelessWidget {
  const UserSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final osmProviderLF = Provider.of<OSMMAPProvider>(context, listen: false);
    final osmProvider = Provider.of<OSMMAPProvider>(context);
    final userDetailsPro =
        Provider.of<UserDetailsProvider>(context, listen: false);
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
              TextButton(
                onPressed: () {
                  if (osmProvider.secondFocusNode.hasFocus) {
                    osmProvider.dropOffTextController.text =
                        userDetailsPro.userCurrentLocation.toString();
                    osmProvider.dropOffCoordinates =
                        userDetailsPro.userCurrentLocation;
                    userDetailsPro.dropOffPlace =
                        userDetailsPro.userCurrentLocation.toString();
                    userDetailsPro.dropOffAddress =
                        userDetailsPro.userCurrentLocation.toString();
                  } else {
                    osmProvider.pickUpTextController.text =
                        userDetailsPro.userCurrentLocation.toString();
                    osmProvider.pickUpCoordinates =
                        userDetailsPro.userCurrentLocation;
                    userDetailsPro.pickUpPlace =
                        userDetailsPro.userCurrentLocation.toString();
                    userDetailsPro.pickUpAddress =
                        userDetailsPro.userCurrentLocation.toString();
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.my_location_rounded),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Use current location'),
                    ],
                  ),
                ),
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
                          // TextButton(
                          //     onPressed: () {},
                          //     child: const Text('Use your current location')),
                          TextFormField(
                            focusNode: osmProvider.firstFocusNode,
                            controller: osmProvider.pickUpTextController,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'From?'),
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
                                //Pickup TextField------------------------------
                                if (osmProvider.firstFocusNode.hasFocus) {
                                  osmProvider.coordinates = await osmProviderLF
                                      .getCoordinatesFromAddress(osmProvider
                                          .pickUpTextController.text);
                                  if (osmProvider.coordinates != null) {
                                    osmProvider.pickUpCoordinates =
                                        osmProvider.coordinates;
                                    log('PickUpCoordinates : ${osmProvider.pickUpCoordinates}');
                                  }
                                  osmProvider.pickUpTextController.text =
                                      osmProvider.controller.listSource[index]
                                          .address!.name
                                          .toString();
                                  userDetailsPro.pickUpPlace = osmProvider
                                      .controller
                                      .listSource[index]
                                      .address!
                                      .name;
                                  userDetailsPro.pickUpAddress = osmProvider
                                      .controller.listSource[index].address
                                      .toString();
                                  //DropOff TextField---------------------------
                                } else if (osmProvider
                                    .secondFocusNode.hasFocus) {
                                  osmProvider.coordinates = await osmProviderLF
                                      .getCoordinatesFromAddress(osmProvider
                                          .dropOffTextController.text);
                                  if (osmProvider.coordinates != null) {
                                    osmProvider.dropOffCoordinates =
                                        osmProvider.coordinates;

                                    log('DropOffCoordinates : ${osmProvider.dropOffCoordinates}');
                                  }
                                  osmProvider.dropOffTextController.text =
                                      osmProvider.controller.listSource[index]
                                          .address!.name
                                          .toString();
                                  userDetailsPro.dropOffPlace = osmProvider
                                      .controller
                                      .listSource[index]
                                      .address!
                                      .name;
                                  userDetailsPro.dropOffAddress = osmProvider
                                      .controller.listSource[index].address
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.grey),
                backgroundColor: MaterialStateProperty.all(Colors.black),
                minimumSize: MaterialStateProperty.all(
                  const Size(50, 40),
                ),
              ),
              onPressed: () async {
                log('${osmProvider.pickUpCoordinates!},${osmProvider.dropOffCoordinates}');
                log('Pickup Place: ${osmProvider.pickUpTextController.text}');
                log('DropOff Place: ${osmProvider.dropOffTextController.text}');
                await userDetailsPro.setRide(
                  osmProvider.pickUpCoordinates!,
                  osmProvider.dropOffCoordinates!,
                  userDetailsPro.pickUpPlace!,
                  userDetailsPro.dropOffPlace!,
                  userDetailsPro.pickUpAddress!,
                  userDetailsPro.dropOffAddress!,
                );
                // await userDetailsPro.calculateDis();
                // userDetailsPro.formatDistance();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const UserChooseVehicle(),
                ));
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "next",
                    style: TextStyle(
                        fontFamily: 'SofiaPro',
                        fontSize: 25,
                        color: Colors.white),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
