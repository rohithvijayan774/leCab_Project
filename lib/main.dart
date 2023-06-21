import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lecab/Views/User/user_starting_page.dart';
import 'package:lecab/provider/User/bottom_nav_bar_provider.dart';
import 'package:lecab/provider/User/number_validation.dart';
import 'package:lecab/provider/User/user_details_provider.dart';
import 'package:lecab/provider/User/user_googlemap_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NumberValidationProvider>(
          create: (context) => NumberValidationProvider(),
        ),
        ChangeNotifierProvider<UserBottomNavBarProvider>(
          create: (context) => UserBottomNavBarProvider(),
        ),
        ChangeNotifierProvider<UserDetailsProvider>(
          create: (context) => UserDetailsProvider(),
        ),
        ChangeNotifierProvider<UserGoogleMapProvider>(
          create: (context) => UserGoogleMapProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'leCab',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: const UserStartingPage(),
      ),
    );
  }
}
