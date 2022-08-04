import 'package:flutter/material.dart';
import 'package:mobigic_test/src/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mobigic Test',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const SplashScreen(),
    );
  }
}
