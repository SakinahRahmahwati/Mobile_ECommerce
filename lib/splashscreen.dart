import 'dart:async';

import 'package:ecommerce_sakinah/allproduct.dart';
import 'package:ecommerce_sakinah/gridbajupria.dart';
import 'package:ecommerce_sakinah/gridbajuwanita.dart';
import 'package:ecommerce_sakinah/gridsepatupria.dart';
import 'package:ecommerce_sakinah/gridsepatuwanita.dart';
import 'package:ecommerce_sakinah/homescreen.dart';
import 'package:flutter/material.dart';
import 'gridelectronics.dart';

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
