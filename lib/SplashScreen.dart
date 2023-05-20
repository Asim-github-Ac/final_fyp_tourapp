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
    Timer(Duration(seconds: 7),
            () =>
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder:
                    (context) => AdminClass()
                )
            )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVariables.whiteColor,
      body: Container(
        child: Center(
          child: Hero(
            tag: 'hero',
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 100.0,
              child: Image.network("https://img.freepik.com/free-vector/detailed-travel-logo_23-2148616611.jpg?w=2000"),
            ),
          ),
        ),
      ),
    );
  }
}
