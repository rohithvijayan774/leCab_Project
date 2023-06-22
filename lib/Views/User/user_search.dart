import 'package:flutter/material.dart';
import 'package:lecab/Views/User/user_choose_vehicle.dart';
import 'package:lecab/provider/User/user_details_provider.dart';
import 'package:provider/provider.dart';

class UserSearch extends StatelessWidget {
  const UserSearch({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> searchPlacesList = [
      "HiLite Mall",
      "Railwaystation 4th Platform Road",
      "SM Street, Palayam, Kozhikode, Kerala",
      "Cyberpark Kozhikode"
    ];
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
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Your current location'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller:
                                Provider.of<UserDetailsProvider>(context)
                                    .destinationController,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(), hintText: 'To?'),
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
              Expanded(
                child: ListView.builder(
                  itemCount: searchPlacesList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const UserChooseVehicle(),
                          ),
                        );
                      },
                      leading: const CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.location_on,
                          color: Colors.black,
                          size: 25,
                        ),
                      ),
                      title: Text(
                        searchPlacesList[index],
                        style: const TextStyle(
                            fontSize: 20,
                            // fontWeight: FontWeight.bold,
                            color: Colors.black),
                        // overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: const Text(
                        'Railwaystation 4th Platform Rd, Kuttichira, Kozhikode',
                        style: TextStyle(color: Colors.black45, fontSize: 15),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
