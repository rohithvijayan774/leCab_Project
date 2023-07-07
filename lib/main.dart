import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lecab/Views/splash_screen.dart';
import 'package:lecab/provider/User/auth_provider.dart';
import 'package:lecab/provider/User/bottom_nav_bar_provider.dart';
import 'package:lecab/provider/User/osm_map_provider.dart';
import 'package:lecab/provider/User/user_details_provider.dart';
import 'package:lecab/provider/User/user_googlemap_provider.dart';
import 'package:lecab/provider/splash_screen_provider.dart';
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
        ChangeNotifierProvider<UserDetailsProvider>(
          create: (context) => UserDetailsProvider(),
        ),
        ChangeNotifierProvider<UserBottomNavBarProvider>(
          create: (context) => UserBottomNavBarProvider(),
        ),
        ChangeNotifierProvider<UserGoogleMapProvider>(
          create: (context) => UserGoogleMapProvider(),
        ),
        // ChangeNotifierProvider<SplashScreenProvider>(
        //   create: (context) => SplashScreenProvider(),
        // ),
        ChangeNotifierProvider<OSMMAPProvider>(
          create: (context) => OSMMAPProvider(),
        ),
        // ChangeNotifierProvider<AuthProvider>(
        //   create: (context) => AuthProvider(),
        // ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'leCab',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
