import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
      createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
    );

    await firebaseFirestore
        .collection('users')
        .doc(_uid)
        .set(_userModel!.toMap())
        .then((value) {
      onSuccess();
    });

    //Get the User's current Location Once
    // Position initialPosition = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);
    // _userModel!.userCurrentLocation =
    //     GeoPoint(initialPosition.latitude, initialPosition.longitude);

    // //Start listening to location updates
    // StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
    //         locationSettings:
    //             const LocationSettings(accuracy: LocationAccuracy.high))
    //     .listen((Position position) {
    //   _userModel!.userCurrentLocation =
    //       GeoPoint(position.latitude, position.longitude);
    //   firebaseFirestore
    //       .collection('users')
    //       .doc(_uid)
    //       .set(_userModel!.toMap())
    //       .then((value) {
    //     log('Location updated in Firebase');
    //   });
    // });

    notifyListeners();

    log('data stored successfully');
  }

  setRide(LatLng pickUpCoordinates, LatLng dropOffCoordinates) async {
    log('Ride Setting');
    DocumentReference docRef = firebaseFirestore.collection('users').doc(_uid);
    GeoPoint pickUpLocation =
        GeoPoint(pickUpCoordinates.latitude, pickUpCoordinates.longitude);
    GeoPoint dropOffLocation =
        GeoPoint(dropOffCoordinates.latitude, dropOffCoordinates.longitude);

    log('2nd step');
    await docRef.update({
      'pickUpLocation': pickUpLocation,
      'dropOffLocation': dropOffLocation,
    });
    log('Ride updated successfully');
    notifyListeners();
  }

  deleteRoute() async {
    DocumentReference docRef = firebaseFirestore.collection('users').doc(_uid);
    await docRef.update({
      'pickUpLocation': FieldValue.delete(),
      'dropOffLocation': FieldValue.delete(),
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
        createdAt: snapshot['createdAt'],
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
}
