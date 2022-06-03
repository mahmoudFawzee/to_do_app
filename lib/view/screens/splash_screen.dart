import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            
          },
          child: Text(
            'organize your day',
            style: GoogleFonts.adamina(
              fontSize: 40,
              color: Colors.amber,
            ),
          ),
        ),
      ),
    );
  }
}
