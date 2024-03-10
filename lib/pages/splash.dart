import 'dart:async';
import 'package:ess_hod/pages/login.dart';
import 'package:ess_hod/res/colors.dart';
import 'package:ess_hod/res/images.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splashTimer();
  }

  void splashTimer() {
    Timer(
        const Duration(seconds: 3),
            () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>LoginPage())));
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SvgPicture.asset(essentialLogo),
      ),
    );
  }
}
