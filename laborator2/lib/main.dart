import 'package:flutter/material.dart';
import 'hote_screen.dart';

void main() {
  runApp(BarberShopApp());
}

class BarberShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barber Shop',
      theme: ThemeData(
        // primarySwatch:  Color.fromARGB(26, 255, 255, 255),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
