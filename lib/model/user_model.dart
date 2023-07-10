import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String firstName;
  String surName;
  String phoneNumber;
  String? profilePicture;


  UserModel({
    required this.uid,
    required this.firstName,
    required this.surName,
    required this.phoneNumber,
    this.profilePicture,

  });

//from Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      firstName: map['firstName'] ?? '',
      surName: map['surName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      profilePicture: map['profilePicture'] ?? '',
     
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
    
    };
  }
}
