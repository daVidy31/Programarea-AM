import 'package:flutter/material.dart';

class BookingCard extends StatelessWidget {
  static const String backgroundImage = 'assets/images/background.jpg';
  static const String logoImage = 'assets/images/logo.png';
  static const String sideImage = 'assets/images/img1.png';

  const BookingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              backgroundImage,
              width: double.infinity,
              height: 240,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            child: Image.asset(
              logoImage,
              width: 100,
              height: 100,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
              child: Image.asset(
                sideImage,
                width: 230,
                height: 230,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF363062),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),
              child: const Text(
                'Booking Now',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
