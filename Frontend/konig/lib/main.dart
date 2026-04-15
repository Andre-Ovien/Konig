import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const Konig());
}

class Konig extends StatefulWidget {
  const Konig({super.key});

  @override
  State<Konig> createState() => _KonigState();
}

class _KonigState extends State<Konig> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}