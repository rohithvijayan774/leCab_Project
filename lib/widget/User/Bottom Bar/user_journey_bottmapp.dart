import 'package:flutter/material.dart';
import 'package:lecab/widget/dot_seperator.dart';

// ignore: must_be_immutable
class UserJourneyBottomBar extends StatelessWidget {
  int timeToReach;
  double distanceToDestn;
  String estReachTime;
  String destnName;
  UserJourneyBottomBar({
    required this.estReachTime,
    required this.distanceToDestn,
    required this.timeToReach,
    required this.destnName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 7,
      decoration: const BoxDecoration(
          // color: Colors.grey,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              '$timeToReach mins',
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$distanceToDestn km',
                  style: TextStyle(fontSize: 22, color: Colors.grey.shade500),
                ),
              const  DotSeperator(),
                Text(
                  estReachTime,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 22, color: Colors.grey.shade500),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              destnName,
              style: const TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
