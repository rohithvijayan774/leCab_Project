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
import 'package:intl/intl.dart';
import 'package:lecab/Views/User/user_number_validation.dart';
import 'package:lecab/Views/User/user_otp_verification.dart';
import 'package:lecab/Views/User/user_showing_driver_info.dart';
import 'package:lecab/Views/User/user_starting_page.dart';
import 'package:lecab/Views/splash_screen.dart';
import 'package:lecab/model/user_model.dart';
import 'package:lecab/utils/driver.dart';
import 'package:lecab/widget/User/user_bottom_nav_bar.dart';
import 'package:lecab/widget/authentication_dialogue_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

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
  DateTime? dateTime;
  String? date;
  String? time;

  UserDetailsProvider() {
    checkSignedIn();
    dateTime = DateTime.now();
    date = DateFormat('dd MMM').format(dateTime!);
    time = DateFormat('h:mm a').format(dateTime!).toLowerCase();
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

  //--------------------Image Picker-------------------------------------------

  File? image;
  File? fileName;
  Future<File?> pickImage(BuildContext context) async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        image = File(pickedImage.path);
        fileName = File(pickedImage.name);
        log('$fileName');
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

  Future<String> storeProfilePic(String ref, File file) async {
    log('Store Profile function Called');
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    log(downloadUrl);

    log('Profile pic stored to storage');
    return downloadUrl;
  }

  uploadProfilePic(File profilePic, Function onSuccess) async {
    await storeProfilePic("UsersProfilePic/$_uid", profilePic)
        .then((value) async {
      log(value);
      userModel.profilePicture = value;

      DocumentReference docRef =
          firebaseFirestore.collection('users').doc(_uid);
      docRef.update({'profilePicture': value});
    });
    _userModel = userModel;
    log('profile pic stored to database');
    notifyListeners();
  }

  //-------------------------Database Operation--------------------------
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
      pickUpPlaceNameList: [], dropOffPlaceAddressList: [],
      dropOffPlaceNameList: [], pickUpPlaceAddressList: [], rideDateList: [],
      ridetimeList: [],

      // profilePicture: image.toString(),
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

//---------------------------Store User Current Location---------------------
  LatLng? userCurrentLocation;
  storeUserCurrentLocation() async {
    DocumentReference docRef = firebaseFirestore.collection('users').doc(_uid);

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    GeoPoint latLngPosition = GeoPoint(position.latitude, position.longitude);
    userCurrentLocation =
        LatLng(latLngPosition.latitude, latLngPosition.longitude);

    await docRef.update({'userCurrentLocation': latLngPosition});

    print('User current location stored');
    log(userCurrentLocation.toString());
    notifyListeners();
  }

//---------------------------Setup Ride-------------------------------------
  String? pickUpPlace;
  String? dropOffPlace;
  String? pickUpAddress;
  String? dropOffAddress;
  // DateTime? dateTime;

  setRide(
      LatLng pickUpCoordinates,
      LatLng dropOffCoordinates,
      String pickUpPlaceName,
      String dropOffPlaceName,
      String pickUpPlaceAddress,
      String dropOffPlaceAddress) async {
    log('Ride Setting');
    DocumentReference docRef = firebaseFirestore.collection('users').doc(_uid);
    GeoPoint pickUpLocation =
        GeoPoint(pickUpCoordinates.latitude, pickUpCoordinates.longitude);
    GeoPoint dropOffLocation =
        GeoPoint(dropOffCoordinates.latitude, dropOffCoordinates.longitude);

    pickUpPlace = pickUpPlaceName;
    dropOffPlace = dropOffPlaceName;
    pickUpAddress = pickUpPlaceAddress;
    dropOffAddress = dropOffPlaceAddress;

    pickUpLoc = LatLng(pickUpLocation.latitude, pickUpLocation.longitude);
    dropOffLoc = LatLng(dropOffLocation.latitude, dropOffLocation.longitude);

    pickLat = pickUpLocation.latitude;
    pickLong = pickUpLocation.longitude;
    dropLat = dropOffLocation.latitude;
    dropLong = dropOffLocation.longitude;

    await calculateDis();
    await formatDistance();
    calculateAutoFare();
    calculateCarFare();
    calculateSUVFare();
    log('2nd step');
    await docRef.update({
      'pickUpCoordinates': pickUpLocation,
      'dropOffCoordinates': dropOffLocation,
      'rideDistance': formattedDistance,
      'pickUpPlaceName': pickUpPlaceName,
      'dropOffPlaceName': dropOffPlaceName,
      'pickUpPlaceAddress': pickUpAddress,
      'dropOffPlaceAddress': dropOffAddress,
      'rideDate': date,
      'rideTime': time,
    });
    log('Ride updated successfully');
    notifyListeners();
  }

  Future deleteRoute() async {
    DocumentReference docRef = firebaseFirestore.collection('users').doc(_uid);

    await docRef.update({
      'pickUpCoordinates': null,
      'dropOffCoordinates': null,
      'rideDistance': null,
      'pickUpPlaceName': null,
      'dropOffPlaceName': null,
      'dropOffPlaceAddress': null,
      'pickUpPlaceAddress': null,
      'rideDate': null,
      'rideTime': null,
      'selectedVehicle': null,
      'cabFare': null,
      'isBooked': false,
    });
    await resetCabFare();
    await resetDistance();
    await resetDriver();
    notifyListeners();
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
        profilePicture: snapshot['profilePicture'],
        selectedDriver: snapshot['selectedDriver'],
        dropOffPlaceAddressList:
            (snapshot['dropOffPlaceAddressList'] as List<dynamic>)
                .cast<String>(),
        dropOffPlaceNameList:
            (snapshot['dropOffPlaceNameList'] as List<dynamic>).cast<String>(),
        pickUpPlaceAddressList:
            (snapshot['pickUpPlaceAddressList'] as List<dynamic>)
                .cast<String>(),
        pickUpPlaceNameList:
            (snapshot['pickUpPlaceNameList'] as List<dynamic>).cast<String>(),
        rideDateList:
            (snapshot['rideDateList'] as List<dynamic>).cast<String>(),
        ridetimeList:
            (snapshot['ridetimeList'] as List<dynamic>).cast<String>(),
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
    notifyListeners();
  }

  //clear local data
  Future<void> clearLocalData() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.clear();
    notifyListeners();
  }

  clearNumberField() {
    numberController.clear();
    notifyListeners();
  }

  //Name Details
  // File? image;
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
                _isSignedIn = false;
                // await clearLocalData();
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
      await getDataFromSP();
      await getDataFromFirestore().then(
        (value) => Navigator.push(
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
    // int mtr = (distance % 1000).round();
    return km;
  }

  formatDistance() {
    formattedDistance = convertDistance(distance!);
    log('Distance : $formattedDistance');
  }

  resetDistance() {
    distance = 0;
    formattedDistance = 0;
    notifyListeners();
  }

  //----------------------Taxi fare------------------------------------
  int autoFare = 30;
  int minAutoDist = 2;
  int carFare = 200;
  int minCarDist = 5;
  int suvFare = 225;
  int minSUVDist = 5;

  int calculateAutoFare() {
    if (formattedDistance! > 0 && formattedDistance! < minAutoDist) {
      return autoFare;
    } else if (formattedDistance! >= minAutoDist) {
      for (var i = minAutoDist; i < formattedDistance!; i++) {
        autoFare = autoFare + 15;
      }
    }
    return autoFare;
  }

  int calculateCarFare() {
    if (formattedDistance! > 0 && formattedDistance! < minCarDist) {
      return carFare;
    } else if (formattedDistance! >= minCarDist) {
      for (var i = minCarDist; i < formattedDistance!; i++) {
        carFare = carFare + 18;
      }
    }
    return carFare;
  }

  int calculateSUVFare() {
    if (formattedDistance! > 0 && formattedDistance! < minSUVDist) {
      return suvFare;
    } else if (formattedDistance! >= minSUVDist) {
      for (var i = minSUVDist; i < formattedDistance!; i++) {
        suvFare = suvFare + 20;
      }
    }
    return suvFare;
  }

  resetCabFare() {
    autoFare = 30;
    minAutoDist = 2;
    carFare = 200;
    minCarDist = 5;
    suvFare = 225;
    minSUVDist = 5;
    notifyListeners();
  }

  Future<void> updateSelectedVehicle(String choosenCab, int cabFare) async {
    DocumentReference docRef = firebaseFirestore.collection('users').doc(_uid);
    await docRef.update({
      'selectedVehicle': choosenCab,
      'cabFare': cabFare,
      'isBooked': true,
    });

    notifyListeners();
  }

  Future<void> addDataToLists() async {
    try {
      DocumentSnapshot userSnapshot =
          await firebaseFirestore.collection('users').doc(_uid).get();
      if (!userSnapshot.exists) {
        return;
      }
      UserModel user =
          UserModel.fromMap(userSnapshot.data() as Map<String, dynamic>);
      user.pickUpPlaceNameList.insert(0, pickUpPlace!);
      user.pickUpPlaceAddressList.insert(0, pickUpAddress!);
      user.dropOffPlaceNameList.insert(0, dropOffPlace!);
      user.dropOffPlaceAddressList.insert(0, dropOffAddress!);
      user.rideDateList.insert(0, date!);
      user.ridetimeList.insert(0, time!);

      Map<String, dynamic> updatedUserData = user.toMap();

      await firebaseFirestore
          .collection('users')
          .doc(_uid)
          .update(updatedUserData);
      log('User Data updated successfully');
    } catch (e) {
      log('Error : $e');
    }
    notifyListeners();
  }

  Driver? driver;
  // StreamController<GeoPoint> driverLocationStream =
  //     StreamController<GeoPoint>();
  Future fetchDriver(context, QuerySnapshot driverSnapshot) async {
    log('Fetch..');

    if (userModel.selectedDriver != null) {
      log('Fetch Driver......................');
      CollectionReference driverRef = firebaseFirestore.collection('drivers');

      driverSnapshot = await driverRef
          .where('isOrderAccepted', isEqualTo: true)
          .where('driverid', isEqualTo: userModel.selectedDriver)
          .get();

      for (var doc in driverSnapshot.docs) {
        String driverId = doc['driverid'];
        String driverFirstName = doc['driverFirstName'];
        String driverSurName = doc['driverSurName'];
        GeoPoint driverLocation = doc['driverCurrentLocation'];
        bool isReached = doc['isReached'];
        bool isOrderAccepted = doc['isOrderAccepted'];
        // driverLocationStream.add(driverLocation);

        driver = Driver(
          driverId: driverId,
          driverFirstName: driverFirstName,
          driverSurName: driverSurName,
          driverLocation: driverLocation,
          isReached: isReached,
          isOrderAccepted: isOrderAccepted,
        );

        if (driver != null) {
          log('Entered Isreached');
          if (driver!.isReached == true) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UserDriverInfo(),
              ),
            );
          }
          notifyListeners();
        }
      }
      notifyListeners();
    } else {
      log('selected Driver is Null');
    }
  }

  Future resetDriver() async {
    driver = null;

    DocumentReference docRef = firebaseFirestore.collection('users').doc(_uid);
    await docRef.update({'selectedDriver': null});

    log('Driver is null : ${driver == null}');
    notifyListeners();
  }

//--------------------------------RazorPay-------------------------------

  var razorPay = Razorpay();

  razorPayPayment() {
    razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess());
    razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError());
    razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet());
  }

  handlePaymentSuccess() {}

  handlePaymentError() {}

  handleExternalWallet() {}

  Map<String, dynamic> options = {
    'key': 'rzp_test_ogN2wJ156C8qr7',
    'amount': 100,
    'name': 'leCab',
    'description': 'Pay for your ride',
    'prefill': {
      'contact': '9778386283',
      'email': 'rohithvijayan774@gmail.com',
    }
  };
}
