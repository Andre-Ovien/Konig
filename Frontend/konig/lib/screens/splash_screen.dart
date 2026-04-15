import 'package:flutter/material.dart';
import 'dart:async';
import 'onboarding_screen.dart';

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
      const Duration(seconds: 5),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 21, 109, 24),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/konigg.png',
              width: 85,
            ),
            SizedBox(width: 30,),
            Text(
              'Konig',
              style: TextStyle(color: Colors.white, fontSize: 25, fontWeight:FontWeight.bold)),
            Text(
              'Farm Fresh Delivered to you.',
              style: TextStyle(color: Colors.white),
            )
          ],
        )
      ),
      ),
    );
  }
}