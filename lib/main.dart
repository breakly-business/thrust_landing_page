import 'package:flutter/material.dart';
import 'package:thrust_landing_page/landing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Thrust Landing Page',
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: LandingPage(),
    );

  }

}
