import 'package:cloud_firestore/cloud_firestore.dart';

class Driver {
  final String driverId;
  final String driverFirstName;
  final String driverSurName;
  final GeoPoint driverLocation;

  Driver({
    required this.driverId,
    required this.driverFirstName,
    required this.driverSurName,
    required this.driverLocation,
  });
}
