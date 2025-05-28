import 'dart:async';

import 'package:Mobile_ECommerce/allproduct.dart';
// import 'package:Mobile_ECommerce/gridbajupria.dart';
// import 'package:Mobile_ECommerce/gridbajuwanita.dart';
// import 'package:Mobile_ECommerce/gridsepatupria.dart';
// import 'package:Mobile_ECommerce/gridsepatuwanita.dart';
// import 'package:Mobile_ECommerce/homescreen.dart';
import 'package:flutter/material.dart';
// import 'gridelectronics.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => const AllProduct())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.green,
      // ),
      body: Center(
        child: Image.asset('./lib/assets/shoppingcart2.png'),
      ),
    );
  }
}
