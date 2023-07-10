import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lecab/Views/User/user_number_validation.dart';
import 'package:lecab/Views/User/user_otp_verification.dart';
import 'package:lecab/Views/User/user_starting_page.dart';
import 'package:lecab/Views/splash_screen.dart';
import 'package:lecab/model/user_model.dart';
import 'package:lecab/widget/User/user_bottom_nav_bar.dart';
import 'package:lecab/widget/authentication_dialogue_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetailsProvider extends ChangeNotifier {
  //Number Details
  String? otpError;
  String? _uid;
  String get uid => _uid!;
  UserModel? _userModel;
  UserModel get userModel => _userModel!;
  File? profilePicture;
  LatLng? pickUpLoc;
  LatLng? dropOffLoc;
  double? pickLat;
  double? pickLong;
  double? dropLat;
  double? dropLong;

  UserDetailsProvider() {
    checkSignedIn();
  }

  Country selectedCountry = Country(
      phoneCode: "91",
      countryCode: "IN",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "India",
      example: "India",
      displayName: "India",
      displayNameNoCountryCode: "IN",
      e164Key: "");

  showCountries(context) {
    showCountryPicker(
      context: context,
      countryListTheme: const CountryListThemeData(
        bottomSheetHeight: 600,
      ),
      onSelect: (value) {
        selectedCountry = value;
        notifyListeners();
      },
    );
  }

  TextEditingController numberController = TextEditingController();

  final numberFormKey = GlobalKey<FormState>();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<void> sendOTP(context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AuthenticationDialogueWidget(
          message: 'Authenticating, Please wait...',
        );
      },
    );
    String userPhoneNumber = numberController.text.trim();
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: "+${selectedCountry.phoneCode}$userPhoneNumber}",
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (FirebaseAuthException error) {
        otpError = error.toString();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const UserNumberValidation(),
            ));
        // Navigator.pop(context);

        log("Verification failed $error");
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        // verificationCode = verificationId;
        log(verificationId);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              UserOTPVerification(verificationId: verificationId),
        ));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    log("OTP Sent to ${selectedCountry.phoneCode}$userPhoneNumber");

    notifyListeners();
  }

  verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
    required Function onSuccess,
  }) async {
    showDialog(
      context: context,
      builder: (context) {
        return AuthenticationDialogueWidget(
          message: 'Verifying OTP...',
        );
      },
    );
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOTP);
      User? user = (await firebaseAuth.signInWithCredential(credential)).user;
      if (user != null) {
        _uid = user.uid;
        onSuccess();
      }
      log("OTP correct");
    } catch (e) {
      Navigator.pop(context);
      log('$e');
    }
    notifyListeners();
  }

  //Image Picker
  Future<File?> pickImage(BuildContext context) async {
    File? image;
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        image = File(pickedImage.path);
      }
    } catch (e) {
      log('$e');
    }
    return image;
  }

  selectImage(context) async {
    image = await pickImage(context);
    notifyListeners();
  }

  //Database Operation
  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot =
        await firebaseFirestore.collection('users').doc(_uid).get();

    if (snapshot.exists) {
      log('USER EXISTS');
      return true;
    } else {
      log('NEW USER');
      return false;
    }
  }

  void storeData(BuildContext context, Function onSuccess) async {
    log("Store data called");

    _userModel = UserModel(
      uid: uid,
      firstName: userFirstNameController.text.trim(),
      surName: userSurNameController.text.trim(),
      phoneNumber: firebaseAuth.currentUser!.phoneNumber!,
    );

    await firebaseFirestore
        .collection('users')
        .doc(_uid)
        .set(_userModel!.toMap())
        .then((value) {
      onSuccess();
    });
    notifyListeners();

    log('data stored successfully');
  }

  Future<String> storeProfilePic(String ref, File file) async {
    log('Store Profile function Called');
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadProfilePic() async {
    await storeProfilePic("profilePic/$_uid", profilePicture!);
    notifyListeners();
  }

//---------------------------Setup Ride-------------------------------------

  setRide(LatLng pickUpCoordinates, LatLng dropOffCoordinates) async {
    log('Ride Setting');
    DocumentReference docRef = firebaseFirestore.collection('users').doc(_uid);
    GeoPoint pickUpLocation =
        GeoPoint(pickUpCoordinates.latitude, pickUpCoordinates.longitude);
    GeoPoint dropOffLocation =
        GeoPoint(dropOffCoordinates.latitude, dropOffCoordinates.longitude);

    pickUpLoc = LatLng(pickUpLocation.latitude, pickUpLocation.longitude);
    dropOffLoc = LatLng(dropOffLocation.latitude, dropOffLocation.longitude);

    pickLat = pickUpLocation.latitude;
    pickLong = pickUpLocation.longitude;
    dropLat = dropOffLocation.latitude;
    dropLong = dropOffLocation.longitude;

    await calculateDis();
    formatDistance();

    log('2nd step');
    await docRef.update({
      'pickUpLocation': pickUpLocation,
      'dropOffLocation': dropOffLocation,
      'rideDistance': formattedDistance,
    });
    log('Ride updated successfully');
    notifyListeners();
  }

  deleteRoute() async {
    DocumentReference docRef = firebaseFirestore.collection('users').doc(_uid);
    await docRef.update({
      'pickUpLocation': FieldValue.delete(),
      'dropOffLocation': FieldValue.delete(),
      'rideDistance': FieldValue.delete(),
    });
  }

  Future getDataFromFirestore() async {
    await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      _userModel = UserModel(
        uid: uid,
        firstName: snapshot['firstName'],
        surName: snapshot['surName'],
        phoneNumber: snapshot['phoneNumber'],
      );
      _uid = userModel.uid;
    });
    notifyListeners();
  }

  // Storing data locally
  Future saveUserdDataToSP() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString('user_model', jsonEncode(_userModel!.toMap()));
  }

  //get locally stored data
  Future getDataFromSP() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    String data = sharedPref.getString('user_model') ?? "";
    _userModel = UserModel.fromMap(jsonDecode(data));
    _uid = _userModel!.uid;
  }

  //clear local data
  Future<void> clearLocalData() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.clear();
  }

  clearNumberField() {
    numberController.clear();
    notifyListeners();
  }

  //Name Details
  File? image;
  TextEditingController userFirstNameController = TextEditingController();
  TextEditingController userSurNameController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  final userNameFormKey = GlobalKey<FormState>();

  clearNameFields() {
    userFirstNameController.clear();
    userSurNameController.clear();
    notifyListeners();
  }

  signOut(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          // content: Text("Do you want to SignOut?"),
          title: const Text(
            'Do you want to SignOut?',
            style:
                TextStyle(fontFamily: 'SofiaPro', fontWeight: FontWeight.w600),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 17, fontFamily: "SofiaPro"),
              ),
            ),
            TextButton(
              onPressed: () async {
                await clearLocalData();
                clearNameFields();
                clearNumberField();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (ctx1) => const SplashScreen(),
                    ),
                    (route) => false);
              },
              child: const Text(
                'SignOut',
                style: TextStyle(
                    fontSize: 17, color: Colors.red, fontFamily: "SofiaPro"),
              ),
            ),
          ],
        );
      },
    );
    notifyListeners();
  }

  //----------------------------------
  //for splash screen

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  void checkSignedIn() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    _isSignedIn = sharedPreferences.getBool('is_signedIn') ?? false;
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setBool('is_signedIn', true);
    _isSignedIn = true;

    notifyListeners();
  }

  gotoNextPage(context) async {
    await Future.delayed(const Duration(seconds: 3));
    if (isSignedIn == true) {
      await getDataFromSP().whenComplete(
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UserBottomNavBar(),
          ),
        ),
      );
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UserStartingPage(),
          ));
    }

    notifyListeners();
  }

  //------------------------Calculate Distance-------------------------------

  double? distance;
  int? formattedDistance;

  double calculateDistance(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    return Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
  }

  calculateDis() {
    distance = calculateDistance(
      pickLat!,
      pickLong!,
      dropLat!,
      dropLong!,
    );
    // log('DIstance $distance');
  }

  int convertDistance(double distance) {
    int km = (distance ~/ 1000);
    int mtr = (distance % 1000).round();
    return km;
  }

  formatDistance() {
    formattedDistance = convertDistance(distance!);
    log('Distance : $formattedDistance');
  }
}
