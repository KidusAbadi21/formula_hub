import 'package:flutter/material.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const FormulaHub());
}

class FormulaHub extends StatelessWidget {
  const FormulaHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
}