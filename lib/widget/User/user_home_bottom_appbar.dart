import 'package:flutter/material.dart';
import 'package:lecab/Views/User/user_search.dart';

class UserHomeBottomAppBar extends StatelessWidget {
  const UserHomeBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      decoration: const BoxDecoration(
          // color: Colors.grey,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Your Last Ride To,',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: double.infinity,
              height: 80,
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
                  elevation: const MaterialStatePropertyAll(0),
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.grey.shade200),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const UserSearch(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.location_on,
                  color: Colors.black,
                  size: 25,
                ),
                label: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'HiLite Mall',
                      style: TextStyle(
                          fontSize: 23,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      'G1003, NH 66, Kozhikode Bypass, Poovangal, Kozhikode',
                      style: TextStyle(color: Colors.black45, fontSize: 15),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 80,
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
                  elevation: const MaterialStatePropertyAll(0),
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.grey.shade200),
                ),
                onPressed: () {},
                icon: const Icon(
                  Icons.local_taxi_rounded,
                  color: Colors.black,
                  size: 25,
                ),
                label: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Hire Cab',
                      style: TextStyle(
                          fontSize: 23,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
