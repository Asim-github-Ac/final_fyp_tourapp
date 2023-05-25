import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tourist_admin/Dashboard/AdminFile.dart';

import 'package:tourist_admin/utils/universal_variables.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 7),
            () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AdminClass())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 232, 217),
      body: Container(
        child: Center(
          child: Hero(
            tag: 'hero',
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 100.0,
              child: Image.asset(
                "assests/logo.jpg",
              ),


            ),


          ),

        ),

      ),
    );
  }
}
