import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lecab/Screens/User/user_starting_page.dart';
import 'package:lecab/provider/number_validation.dart';
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
        )
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
