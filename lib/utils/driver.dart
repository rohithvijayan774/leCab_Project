import 'package:cloud_firestore/cloud_firestore.dart';

class Driver {
  final String driverId;
  final String driverFirstName;
  final String driverSurName;
  final GeoPoint driverLocation;
  final bool isReached;
  final bool isOrderAccepted;

  Driver({
    required this.driverId,
    required this.driverFirstName,
    required this.driverSurName,
    required this.driverLocation,
    required this.isReached,
    required this.isOrderAccepted,
  });
}
