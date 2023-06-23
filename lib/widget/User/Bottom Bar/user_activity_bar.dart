import 'package:flutter/material.dart';
import 'package:lecab/widget/dot_seperator.dart';

// ignore: must_be_immutable
class UserActivityBar extends StatelessWidget {
  String bookedTime;
  String bookedDate;
  String dropOffLoc;
  UserActivityBar({
    required this.bookedDate,
    required this.bookedTime,
    required this.dropOffLoc,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: const CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Icon(
          Icons.share_location_sharp,
          color: Colors.black,
          size: 30,
        ),
      ),
      title: Text(
        dropOffLoc,
        style: const TextStyle(
            fontFamily: 'SofiaPro', fontWeight: FontWeight.w800, fontSize: 18),
      ),
      subtitle: Row(
        children: [
          Text(
            bookedDate,
            style: const TextStyle(
                fontFamily: 'SofiaPro',
                fontWeight: FontWeight.bold,
                color: Colors.grey),
          ),
          const DotSeperator(),
          Text(
            bookedTime,
            style: const TextStyle(
                fontFamily: 'SofiaPro',
                fontWeight: FontWeight.bold,
                color: Colors.grey),
          ),
        ],
      ),
      trailing: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(
          Icons.replay_circle_filled_outlined,
          size: 20,
          color: Colors.black,
        ),
        label: const Text(
          'Rebook',
          style: TextStyle(
              fontFamily: 'SofiaPro',
              fontWeight: FontWeight.w700,
              color: Colors.black),
        ),
      ),
    );
  }
}
