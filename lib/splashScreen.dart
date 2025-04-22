// splash_screen.dart
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:edu_orbit/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    
    // Set a timer to navigate after 2 seconds
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
          transitionDuration: Duration(milliseconds: 1500), 
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Hero(
          tag: 'logo',
          flightShuttleBuilder: (
            BuildContext flightContext,
            Animation<double> animation,
            HeroFlightDirection flightDirection,
            BuildContext fromHeroContext,
            BuildContext toHeroContext,
          ) {
            // Create a much slower, curved animation
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              // Using a very slow ease-in-out curve
              curve: Curves.easeInOutCubic,
            );
            
            return AnimatedBuilder(
              animation: curvedAnimation,
              child: Image.asset(
                'assets/images/logo.png',
                width: 263,
                height: 79,
              ),
              builder: (context, child) {
                return child!;
              },
            );
          },
          child: Image.asset(
            'assets/images/logo.png',
            width: 263,
            height: 79,
          ),
        ),
      ),
    );
  }
}
