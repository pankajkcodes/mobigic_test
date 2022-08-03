import 'package:flutter/material.dart';
import 'package:mobigic_test/src/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobigic Test',
      theme: ThemeData(

        primarySwatch: Colors.cyan,
      ),
      home: const SplashScreen(),
    );
  }
}


