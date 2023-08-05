// import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String firstName;
  String surName;
  String phoneNumber;
  String? profilePicture;
  GeoPoint? pickUpCoordinates;
  GeoPoint? dropOffCoordinates;
  GeoPoint? userCurrentLocation;
  int? rideDistance;
  int? cabFare;
  String? selectedVehicle;
  String? pickUpPlaceName;
  String? dropOffPlaceName;
  String? pickUpPlaceAddress;
  String? dropOffPlaceAddress;
  String? rideDate;
  String? rideTime;
  bool isBooked;
  List<String> pickUpPlaceNameList = [];
  List<String> pickUpPlaceAddressList = [];
  List<String> dropOffPlaceNameList = [];
  List<String> dropOffPlaceAddressList = [];
  List<String> rideDateList = [];
  List<String> ridetimeList = [];
  String? selectedDriver;

  UserModel({
    required this.uid,
    required this.firstName,
    required this.surName,
    required this.phoneNumber,
    this.profilePicture,
    this.pickUpCoordinates,
    this.dropOffCoordinates,
    this.rideDistance,
    this.pickUpPlaceName,
    this.dropOffPlaceName,
    this.userCurrentLocation,
    this.pickUpPlaceAddress,
    this.dropOffPlaceAddress,
    this.rideDate,
    this.rideTime,
    this.cabFare,
    this.selectedVehicle,
    this.isBooked = false,
    required this.pickUpPlaceNameList,
    required this.pickUpPlaceAddressList,
    required this.dropOffPlaceAddressList,
    required this.dropOffPlaceNameList,
    required this.rideDateList,
    required this.ridetimeList,
    this.selectedDriver,
  });

//from Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      firstName: map['firstName'] ?? '',
      surName: map['surName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      profilePicture: map['profilePicture'],
      pickUpCoordinates: map['pickUpCoordinates'],
      dropOffCoordinates: map['dropOffCoordinates'],
      rideDistance: map['rideDistance'],
      pickUpPlaceName: map['pickUpPlaceName'] ?? '',
      dropOffPlaceName: map['dropOffPlaceName'] ?? '',
      userCurrentLocation: map['userCurrentLocation'],
      pickUpPlaceAddress: map['pickUpPlaceAddress'] ?? '',
      dropOffPlaceAddress: map['dropOffPlaceAddress'] ?? '',
      rideDate: map['rideDate'] ?? '',
      rideTime: map['rideTime'] ?? '',
      cabFare: map['cabFare'],
      selectedVehicle: map['selectedVehicle'] ?? '',
      selectedDriver: map['selectedDriver'],
      isBooked: map['isBooked'],
      pickUpPlaceNameList: (map['pickUpPlaceNameList'] as List<dynamic>?)!
          .map((item) => item.toString())
          .toList()
          .cast<String>(),
      pickUpPlaceAddressList: (map['pickUpPlaceAddressList'] as List<dynamic>?)!
          .map((item) => item.toString())
          .toList()
          .cast<String>(),
      dropOffPlaceNameList: (map['dropOffPlaceNameList'] as List<dynamic>?)!
          .map((item) => item.toString())
          .toList()
          .cast<String>(),
      dropOffPlaceAddressList:
          (map['dropOffPlaceAddressList'] as List<dynamic>?)!
              .map((item) => item.toString())
              .toList()
              .cast<String>(),
      rideDateList: (map['rideDateList'] as List<dynamic>?)!
          .map((item) => item.toString())
          .toList()
          .cast<String>(),
      ridetimeList: (map['ridetimeList'] as List<dynamic>?)!
          .map((item) => item.toString())
          .toList()
          .cast<String>(),
    );
  }

//to Map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'surName': surName,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'pickUpCoordinates': pickUpCoordinates,
      'dropOffCoordinates': dropOffCoordinates,
      'rideDistance': rideDistance,
      'pickUpPlaceName': pickUpPlaceName,
      'dropOffPlaceName': dropOffPlaceName,
      'userCurrentLocation': userCurrentLocation,
      'pickUpPlaceAddress': pickUpPlaceAddress,
      'dropOffPlaceAddress': dropOffPlaceAddress,
      'rideDate': rideDate,
      'rideTime': rideTime,
      'cabFare': cabFare,
      'selectedVehicle': selectedVehicle,
      'isBooked': isBooked,
      'pickUpPlaceNameList': pickUpPlaceNameList,
      'pickUpPlaceAddressList': pickUpPlaceAddressList,
      'dropOffPlaceNameList': dropOffPlaceNameList,
      'dropOffPlaceAddressList': dropOffPlaceAddressList,
      'rideDateList': rideDateList,
      'ridetimeList': ridetimeList,
      'selectedDriver': selectedDriver,
    };
  }
}
