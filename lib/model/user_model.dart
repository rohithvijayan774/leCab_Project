
class UserModel {
  String uid;
  String firstName;
  String surName;
  String phoneNumber;
  String createdAt;

  UserModel({
    required this.uid,
    required this.firstName,
    required this.surName,
    required this.phoneNumber,
    required this.createdAt,
  });

//from Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      firstName: map['firstName'] ?? '',
      surName: map['surName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      createdAt: map['createdAt'] ?? '',
    );
  }

//to Map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'surName': surName,
      'phoneNumber': phoneNumber,
      'createdAt': createdAt,
    };
  }
}
