import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const DreamBuilderApp());
}

class DreamBuilderApp extends StatelessWidget {
  const DreamBuilderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}